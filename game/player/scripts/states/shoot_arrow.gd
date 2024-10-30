class_name ShootArrow extends PlayerState

@export var next_state: PlayerState
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

var animation_name = "bow_attack"
var ended: bool = false

const ArrowCene = preload("res://player/arrow.tscn")

func init():
	pass
	
func enter() -> void:
	var arrow = ArrowCene.instantiate() as Arrow
	arrow.shoot(player.faced_direction())
	player.add_sibling(arrow)
	player.update_animation(animation_name)
	player.velocity = Vector2.ZERO
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
