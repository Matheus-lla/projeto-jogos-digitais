extends State

var finished

@export var animation_name: String = "burning_attack"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func enter():
	finished = false
	character.update_animation(animation_name)
	animation_player.animation_finished.connect(on_animation_finished)

func exit():
	animation_player.animation_finished.disconnect(on_animation_finished)

func process( delta: float) -> State:
	if finished:
		return self
		
	return null

func on_animation_finished(_animation_name: String):
	finished = true
