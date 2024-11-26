class_name EnemyStateCombat extends State

var states: Array[State]
@export_category("AI")
@export var state_duration_min: float = 0.5
@export var state_duration_max: float = 1.5
@export var next_state: State

var timer: float = 0.0

func init():
	for state in get_children():
		if state is State:
			state.character = character
			state.state_machine = state_machine
			states.append(state)

func enter() -> void:
	pass
	
func process( delta: float) -> State:
	timer -= delta
	
	if timer <= 0:
		return next_state
		
	return null
