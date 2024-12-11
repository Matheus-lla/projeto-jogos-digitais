class_name AnhangaStateMachine extends StateMachine

@onready var idle: EnemyStateIdle = $Idle
@onready var chase: Node = $Chase

const threasshold: float = 200.0

func init(character: Character) -> void:
	states = []
	
	for state in get_children():
		if state is State:
			if state is EnemyStateDestroy or state is EnemyStateStun:
				continue
				
			state.character = character
			state.state_machine = self
			state.init()
			states.append(state)
	
	# Static variable
	states[0].player = GlobalPlayerManager.player
	
	update_state(idle)
	process_mode = Node.PROCESS_MODE_INHERIT


func change_state(new_state: State) -> void:
	if new_state == null:
		return

	if not new_state.character.is_in_combat:
		update_state(idle)
		return
		
	var distance = new_state.character.global_position.distance_to(new_state.player.global_position)
	
	if distance >= threasshold:
		update_state(chase)
	
	var random_state = states[randi_range(0, states.size() -1)]

	update_state(random_state)

func update_state(next_state: State):
	if curr_state:
		curr_state.exit()

	prev_state = curr_state
	curr_state = next_state
	curr_state.enter()
