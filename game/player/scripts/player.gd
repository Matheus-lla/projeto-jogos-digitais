class_name Player extends Character

var max_hp: int = 6
var kills: int = 0
var in_guarana: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var effect_animation_player: AnimationPlayer = $EffectAnimationPlayer
@onready var sprite: Sprite2D = $PlayerSprite
@onready var hit_box: HitBox = $HitBox
@onready var idle: Idle = $StateMachine/Idle
@onready var spawn_place: Spawn = $"../Spawn"

func _ready() -> void:
	GlobalPlayerManager.player = self
	state_machine.init(self)
	hit_box.Damaged.connect(on_damaged)
	spawn()

func _process(_delta: float) -> void:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down"),
	).normalized()
	
func set_direction(_new_direction: Vector2 = Vector2.ZERO) -> bool:
	if direction == Vector2.ZERO:
		return false
		
	return super.set_direction(direction)
	
func update_animation(state_str: String) -> void:
	animation_player.play(state_str + "_" + animation_direction())
	return
	
func update_hp(delta: int):
	hp = clampi(hp + delta, 0, max_hp)
	PlayerHud.update_hp(hp, max_hp)
	
func make_invulnerable(duration: float):
	if duration <= 0:
		return
	
	invulnerable = true
	hit_box.monitoring = false
	await get_tree().create_timer(duration).timeout
	invulnerable = false
	hit_box.monitoring = true
	
func on_damaged(hurt_box: HurtBox):
	if invulnerable:
		return
		
	update_hp(-hurt_box.damage)
	
	if hp <= 0:
		self.spawn()
		return	
	
	CharacterDamaged.emit(hurt_box)

func spawn():
	update_hp(max_hp)
	PlayerHud.update_potion(PlayerHud.max_potion)
	PlayerHud.update_guarana(-PlayerHud.guarana)
	
	for c in get_parent().get_children(false):
		if c is Guarana:
			c.guarana_spawm()
	
	
	if spawn_place:
		self.global_position = spawn_place.global_position
		
	direction = Vector2.DOWN
	cardinal_direction	= Vector2.DOWN		
	set_direction()
	animation_player.play("idle_down")
	state_machine.change_state(idle)
	
func faced_direction() -> Vector2:
	var dir = direction
	
	if dir == Vector2.ZERO:
		dir = cardinal_direction
		
	return dir
	
