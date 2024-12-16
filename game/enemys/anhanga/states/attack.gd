extends State

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var hurt_box: HurtBox = $"../../HurtBox"

@export var anim_name: String
@export var turn_rate: float = 0.5
@export var damage: int

var finished = true
var _direction : Vector2
var timer: float

const LOADING_TIME: float = 0.4

func enter() -> void:
	character.update_animation(anim_name)
	finished = false
	timer = LOADING_TIME
	animation_player.animation_finished.connect(on_animation_finished)

func exit() -> void:
	animation_player.animation_finished.disconnect(on_animation_finished)
	hurt_box.monitoring = false

func on_animation_finished(_animation_name: String):
	finished = true

func process( delta: float) -> State:
	timer -= delta
	
	if timer <= 0:
		hurt_box.damage = damage
		hurt_box.monitoring = true
	
	if finished:
		return self
	
	var new_dir : Vector2 = player.global_position - character.global_position
	_direction = lerp( _direction.normalized(), new_dir.normalized(), turn_rate ).normalized()
	character.velocity = _direction * character.chase_speed
	
	if character.set_direction( _direction ):
		character.update_animation( anim_name )
	
	return null
