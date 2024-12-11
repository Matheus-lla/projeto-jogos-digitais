extends State

@export var anim_name : String = "walking"
@export var turn_rate : float = 0.5

var _direction : Vector2
var timer: float

const MIN_TIME: float = 0.32

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func enter() -> void:
	character.update_animation( anim_name )
	timer = MIN_TIME

func process( delta : float ) -> State:
	timer -= delta
	
	if timer <= 0:
		return self
	
	var new_dir : Vector2 = player.global_position - character.global_position
	_direction = lerp( _direction, new_dir.normalized(), turn_rate )
	character.velocity = _direction * character.chase_speed
	
	if character.set_direction( _direction ):
		character.update_animation( anim_name )
	
	return null
