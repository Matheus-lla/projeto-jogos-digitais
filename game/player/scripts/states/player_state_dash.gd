class_name Dash extends PlayerState

@export var move_speed: float = 200.0
@onready var idle: PlayerState = $"../Idle"
@onready var attack: PlayerState = $"../Attack"

func init():
	pass

func enter() -> void:
	player.update_animation("walking")
	pass

func exit() -> void:
	pass
	
func process( _delta: float) -> PlayerState:
	if player.direction == Vector2.ZERO:
		return idle
		
	player.velocity = move_speed * player.direction
	
	if player.set_direction():
		player.update_animation("walking")
		
	return null
	
func physics(_delta: float) -> PlayerState:
	return null

func handle_input(event: InputEvent) -> PlayerState:
	if event.is_action("attack"):
		return attack
		
	if event.is_action("interact"):
		GlobalPlayerManager.interact_pressed.emit()
		
	return null
