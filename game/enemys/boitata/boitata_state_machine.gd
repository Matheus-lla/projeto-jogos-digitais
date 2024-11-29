class_name BoitataStateMachine extends StateMachine

var default_state: State

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
	
	default_state = states[0]
	change_state(states[0])
	process_mode = Node.PROCESS_MODE_INHERIT


func change_state(new_state: State) -> void:
	if new_state == null:
		return

	if not new_state.character.is_in_combat:
		update_state(default_state)
		return
	
	var random_state = null
	while random_state == null or random_state is BoitataStateDestroy or random_state is BoitataStateStun:
		random_state = states[randi_range(0, states.size() -1)]

	update_state(random_state)

func update_state(next_state: State):
	if curr_state:
		curr_state.exit()

	prev_state = curr_state
	curr_state = next_state
	curr_state.enter()
