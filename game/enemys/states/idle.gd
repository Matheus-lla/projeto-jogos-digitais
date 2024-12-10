class_name EnemyStateIdle extends State

@export var anim_name: String = "idle"
@export_category("AI")
@export var state_duration_min: float = 0.5
@export var state_duration_max: float = 1.5
@export var next_state: State

var timer: float = 0.0

func enter() -> void:
	character.velocity = Vector2.ZERO
	timer = randf_range(state_duration_min, state_duration_max)
	character.update_animation(anim_name)
	
func process( delta: float) -> State:
	timer -= delta
	
	if timer <= 0:
		return next_state
		
	return null
	
func physics(_delta: float) -> State:
	return null
