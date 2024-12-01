class_name Walk extends State

@export var move_speed: float = 150.0
@onready var idle: State = $"../Idle"
@onready var attack: State = $"../Attack"
@onready var dash: Dash = $"../Dash"
@onready var shoot_arrow: ShootArrow = $"../ShootArrow"
@onready var drinking_potion: DrinkingPotion = $"../DrinkingPotion"

func enter() -> void:
	player.update_animation("walking")
	
func process( _delta: float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
		
	player.velocity = move_speed * player.direction
	
	if player.set_direction():
		player.update_animation("walking")
		
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
