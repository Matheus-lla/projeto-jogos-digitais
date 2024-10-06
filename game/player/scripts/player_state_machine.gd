class_name PlayerStateMachine extends Node

var states: Array[PlayerState]
var prev_state: PlayerState
var curr_state: PlayerState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_state(curr_state.process(delta))
	
func _physics__process(delta: float) -> void:
	change_state(curr_state.physics(delta))
	
func _unhandled_input(event: InputEvent) -> void:
	change_state(curr_state.handle_input(event))
	
func init(player: Player) -> void:
	states = []
	
	for c in get_children():
		if c is PlayerState:
			states.append(c)
	
	if states.size() > 0:
		states[0].player = player
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT
	

func change_state(new_state: PlayerState) -> void:
	if new_state == null || new_state == curr_state:
		return
		
	if curr_state:
		curr_state.exit()	
		
	prev_state = curr_state
	curr_state = new_state
	curr_state.enter()
