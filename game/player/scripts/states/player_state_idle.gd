class_name Idle extends PlayerState

@onready var walk: PlayerState = $"../Walk"
@onready var attack: PlayerState = $"../Attack"
@onready var dash: Dash = $"../Dash"

func init():
	pass

func enter() -> void:
	player.update_animation("idle")
	pass

func exit() -> void:
	pass
	
func process( _delta: float) -> PlayerState:
	if player.direction != Vector2.ZERO:
		return walk
	
	player.velocity = Vector2.ZERO
	return null
	
func physics(_delta: float) -> PlayerState:
	return null

func handle_input(event: InputEvent) -> PlayerState:
	if event.is_action("attack"):
		return attack
		
	if event.is_action("dash"):
		return dash
		
	if event.is_action("interact"):
		GlobalPlayerManager.interact_pressed.emit()
	
	return null
