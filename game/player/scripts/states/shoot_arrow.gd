class_name ShootArrow extends PlayerState

@export var next_state: PlayerState
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

var animation_name = "bow_attack"
var ended: bool = false

func init():
	pass
	
func enter() -> void:
	player.update_animation(animation_name)
	animation_player.animation_finished.connect(on_animation_finished)
	ended = false
	
func exit() -> void:
	animation_player.animation_finished.disconnect(on_animation_finished)
	
func process(_delta: float) -> PlayerState:
	if ended:
		return next_state
		
	return null
	
func physics(_delta: float) -> PlayerState:
	return null

func handle_input(_event: InputEvent) -> PlayerState:
	return null
	
func on_animation_finished(_animation_name: String):
	ended = true
