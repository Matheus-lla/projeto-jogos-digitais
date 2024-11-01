class_name EnemyStateMachine extends Node

var states: Array[EnemyState]
var prev_state: EnemyState
var curr_state: EnemyState

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
	change_state(curr_state.process(delta))

func _physics_process(delta: float) -> void:
	change_state(curr_state.physics(delta))

func init(enemy: Enemy) -> void:
	states = []
	
	for c in get_children():
		if c is EnemyState:
			states.append(c)
	
	for state in states:
		state.enemy = enemy
		#state.state_machine = self
		state.init()

	if states.size() > 0:
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT
	

func change_state(new_state: EnemyState) -> void:
	if new_state == null || new_state == curr_state:
		return
		
	if curr_state:
		curr_state.exit()	
		
	prev_state = curr_state
	curr_state = new_state
	curr_state.enter()
