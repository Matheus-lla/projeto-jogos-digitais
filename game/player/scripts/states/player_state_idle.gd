class_name Idle extends State

@onready var walk: State = $"../Walk"
@onready var attack: State = $"../Attack"
@onready var dash: Dash = $"../Dash"
@onready var shoot_arrow: ShootArrow = $"../ShootArrow"
@onready var drinking_potion: DrinkingPotion = $"../DrinkingPotion"

func enter() -> void:
	player.update_animation("idle")

func process( _delta: float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	
	player.velocity = Vector2.ZERO
	return null
	
func handle_input(event: InputEvent) -> State:
	if event.is_action("attack"):
		return attack
		
	if event.is_action("dash"):
		return dash
		
	if event.is_action("shoot_arrow"):
		return shoot_arrow
		
	if event.is_action_pressed("interact"):
		GlobalPlayerManager.interact_pressed.emit()
		
	if event.is_action("use_potion"):
		return drinking_potion
	
	return null
