class_name ShootArrow extends PlayerState

@export var next_state: PlayerState
@export var attack_sound: AudioStream

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"


var animation_name = "bow_attack"
var ended: bool = false
var timer: float
var audio_played: bool

const ArrowCene = preload("res://player/arrow.tscn")
const LOADING_TIME = 0.50 # time to pull the arrow and released

func init():
	pass
	
func enter() -> void:
	var arrow = ArrowCene.instantiate() as Arrow
	arrow.shoot()
	player.add_sibling(arrow)
	player.velocity = Vector2.ZERO
	player.update_animation(animation_name)
	animation_player.animation_finished.connect(on_animation_finished)
	audio.stream = attack_sound
	timer = LOADING_TIME
	ended = false
	audio_played = false
	
func exit() -> void:
	animation_player.animation_finished.disconnect(on_animation_finished)
	
func process(delta: float) -> PlayerState:
	if ended:
		return next_state
		
	timer -= delta
	if timer <= 0 && !audio_played:
		audio.play()
		audio_played = true
		
	return null
	
func physics(_delta: float) -> PlayerState:
	return null

func handle_input(_event: InputEvent) -> PlayerState:
	return null
	
func on_animation_finished(_animation_name: String):
	ended = true
