class_name EnemyStateIdle extends State


@export var anim_name : String = "idle"

@export_category("AI")
@export var state_duration_min : float = 0.5
@export var state_duration_max : float = 1.5
@export var after_idle_state : State

var _timer : float = 0.0

func enter() -> void:
	character.velocity = Vector2.ZERO
	_timer = randf_range( state_duration_min, state_duration_max )
	character.update_animation( anim_name )
	pass


func process( _delta : float ) -> State:
	_timer -= _delta
	if _timer <= 0:
		return after_idle_state
	return null
