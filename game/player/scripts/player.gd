class_name Player extends CharacterBody2D

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var invulnerable: bool = false
var hp: int = 6
var max_hp: int = 12
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var effect_animation_player: AnimationPlayer = $EffectAnimationPlayer
@onready var sprite: Sprite2D = $PlayerSprite
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var hit_box: HitBox = $HitBox

signal DirectionChanged(new_directions: Vector2)
signal PlayerDamaged(hurt_box: HurtBox)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalPlayerManager.player = self
	state_machine.init(self)
	hit_box.Damaged.connect(on_damaged)
	update_hp(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down"),
	).normalized()
	
func _physics_process(_delta: float) -> void:
	move_and_slide()
	
func set_direction() -> bool:
	if direction == Vector2.ZERO:
		return false
		
	var direction_index: int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_direction = DIR_4[direction_index]
	
	if new_direction == cardinal_direction:
		return false
		
	cardinal_direction = new_direction
	DirectionChanged.emit(new_direction)
	#sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true
	
func update_animation(state_str: String) -> void:
	animation_player.play(state_str + "_" + animation_direction())
	return
	
func animation_direction() -> String:
	if cardinal_direction == Vector2.DOWN: return "down"
	elif cardinal_direction == Vector2.UP: return "up"
	elif cardinal_direction == Vector2.RIGHT: return "right"
	return "left"
	
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
		update_hp(max_hp)
	
	PlayerDamaged.emit(hurt_box)
