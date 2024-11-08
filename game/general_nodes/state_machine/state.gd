class_name State extends Node

static var player: Player
static var character: CharacterBody2D
static var state_machine: StateMachine

func init():
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass
	
func process( _delta: float) -> State:
	return null
	
func physics(_delta: float) -> State:
	return null

func handle_input(_event: InputEvent) -> State:
	return null
