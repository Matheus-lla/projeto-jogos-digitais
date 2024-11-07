class_name VillagerStateMachine extends Node

var states: Array[VillagerState]
var prev_state: VillagerState
var curr_state: VillagerState

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
	change_state(curr_state.process(delta))

func _physics_process(delta: float) -> void:
	change_state(curr_state.physics(delta))

func init(villager: Villager) -> void:
	states = []
	
	for c in get_children():
		if c is VillagerState:
			states.append(c)
	
	for state in states:
		state.villager = villager
		#state.state_machine = self
		state.init()

	if states.size() > 0:
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT
	

func change_state(new_state: VillagerState) -> void:
	if new_state == null || new_state == curr_state:
		return
		
	if curr_state:
		curr_state.exit()	
		
	prev_state = curr_state
	curr_state = new_state
	curr_state.enter()
