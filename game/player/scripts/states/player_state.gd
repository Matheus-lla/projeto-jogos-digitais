class_name PlayerState extends Node

static var player: Player
static var state_machine: PlayerStateMachine

func init():
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass
	
func process( _delta: float) -> PlayerState:
	return null
	
func physics(_delta: float) -> PlayerState:
	return null

func handle_input(_eventL: InputEvent) -> PlayerState:
	return null
