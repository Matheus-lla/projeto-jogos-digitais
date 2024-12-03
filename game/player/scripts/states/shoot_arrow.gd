class_name ShootArrow extends State

@export var next_state: State
@export var attack_sound: AudioStream

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio"
@onready var walk: Walk = $"../Walk"


var animation_name = "bow_attack"
var ended: bool = false
var timer: float
var audio_played: bool

const ArrowCene = preload("res://player/arrow.tscn")
const LOADING_TIME = 0.35 # time to pull the arrow and released
const ANIMATION_CANCEL_TIME = 0.5

func enter() -> void:
	var arrow = ArrowCene.instantiate() as Arrow
	arrow.global_position = player.global_position 
	arrow.shoot(player.bow.get_value())
	player.add_sibling(arrow)
	player.velocity = Vector2.ZERO
	player.update_animation(animation_name)
	animation_player.animation_finished.connect(on_animation_finished)
	audio.stream = attack_sound
	timer = 0
	ended = false
	audio_played = false
	
func exit() -> void:
	audio.pitch_scale = 1.0
	animation_player.animation_finished.disconnect(on_animation_finished)
	
func play_audio():
	audio.pitch_scale = 1.1
	audio.play()
	audio_played = true

func process(delta: float) -> State:
	timer += delta
	
	if ended:
		return next_state
		
	if timer >= LOADING_TIME && !audio_played:
		play_audio()
	
	if timer >= ANIMATION_CANCEL_TIME and player.direction != Vector2.ZERO:
		return walk

	return null

func on_animation_finished(_animation_name: String):
	ended = true
