class_name EnemyStateWander extends State

@export var anim_name : String = "walk"
@export var wander_speed : float = 20.0

@export_category("AI")
@export var state_animation_duration : float = 0.5
@export var state_cycles_min : int = 1
@export var state_cycles_max : int = 3
@export var next_state : State

var _timer : float = 0.0
var _direction : Vector2

func enter() -> void:
	_timer = randi_range( state_cycles_min, state_cycles_max ) * state_animation_duration
	var rand = randi_range( 0, 3 )
	_direction = character.DIR_4[ rand ]
	character.velocity = _direction * wander_speed
	character.set_direction( _direction )
	character.update_animation( anim_name )
	pass

func process( _delta : float ) -> State:
	_timer -= _delta
	if _timer < 0:
		return next_state
	return null
