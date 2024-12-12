class_name Player extends Character

var wepon = Upgradable.new("Arma", [20, 40, 80], [2, 4, 6, 8])
var bow = Upgradable.new("Arco", [15, 30, 60], [1, 2, 3, 4])
var max_hp = Upgradable.new("Vida", [10, 30, 100], [2, 4, 6, 8])
var heal = Upgradable.new("Cura", [10, 25, 50], [2, 3, 4, 5])

@export var spawn_place: Spawn

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var effect_animation_player: AnimationPlayer = $EffectAnimationPlayer
@onready var sprite: Sprite2D = $PlayerSprite
@onready var hit_box: HitBox = $HitBox
@onready var idle: Idle = $StateMachine/Idle
@onready var melee_hurt_box: HurtBox = $MeleeHurtBox
@onready var camera: Camera = $Camera
@onready var death: Death = $Death

func _ready() -> void:
	GlobalPlayerManager.player = self
	state_machine.init(self)
	hit_box.Damaged.connect(on_damaged)
	spawn()
	PlayerHud.update_guarana(100)
	wepon.Upgraded.connect(on_wepon_upgrade)
	max_hp.Upgraded.connect(on_max_hp_upgrade)
	heal.Upgraded.connect(on_heal_upgrade)
	death.restart.connect(on_restart)
	
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
	hp = clampi(hp + delta, 0, max_hp.get_value())
	PlayerHud.update_hp(hp, max_hp.get_value())
	
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
	CharacterDamaged.emit(hurt_box)
	
	if hp <= 0:
		dead()
		return	

func spawn(teleport: bool = true):
	update_hp(max_hp.get_value())
	PlayerHud.update_potion(PlayerHud.max_potion)
	#PlayerHud.update_guarana(-PlayerHud.guarana)
	
	if spawn_place and teleport:
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

func on_wepon_upgrade():
	melee_hurt_box.damage = wepon.get_value()
	
func on_max_hp_upgrade():
	update_hp(max_hp.get_value())
	
func on_heal_upgrade():
	PlayerHud.max_potion = heal.get_value()
	PlayerHud.update_potion(PlayerHud.max_potion)

func dead():
	# Time for stun animation to finish
	await get_tree().create_timer(0.2).timeout
	death.visible = true
	get_tree().paused = true

func on_restart():
	print("oi")
	death.visible = false
	get_tree().paused = false
	spawn()
