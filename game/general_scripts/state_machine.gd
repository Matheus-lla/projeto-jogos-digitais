class_name StateMachine extends Node

var states: Array[State]
var prev_state: State
var curr_state: State

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
	change_state(curr_state.process(delta))
	
func _physics__process(delta: float) -> void:
	change_state(curr_state.physics(delta))
	
func _unhandled_input(event: InputEvent) -> void:
	change_state(curr_state.handle_input(event))
	
func init(character: Character) -> void:
	states = []
	
	for state in get_children():
		if state is State:
			state.character = character
			state.state_machine = self
			states.append(state)
	
	if states.size() <= 0:
		return
		
	states[0].player = GlobalPlayerManager.player
	
	for state in states:
		state.init()
	
	change_state(states[0])
	process_mode = Node.PROCESS_MODE_INHERIT
	

func change_state(new_state: State) -> void:
	if new_state == null || new_state == curr_state:
		return
		
	if curr_state:
		curr_state.exit()	
		
	prev_state = curr_state
	curr_state = new_state
	curr_state.enter()
