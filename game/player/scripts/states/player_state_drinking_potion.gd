class_name DrinkingPotion extends State

@onready var idle: Idle = $"../Idle"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio"

@export var sound1: AudioStream
@export var sound2: AudioStream

var potion_health: int = 2
var ended: bool
var audio2: AudioStreamPlayer2D

func init():
	audio2 = AudioStreamPlayer2D.new()
	add_child(audio2)
	audio2.stream = sound2
	audio2.volume_db = 16

func enter() -> void:
	animation_player.animation_finished.connect(animation_potion_end)
	if (PlayerHud.potions <= 0 || player.hp == player.max_hp):
		ended = true
		return
		
	player.update_hp(potion_health)
	player.velocity = Vector2.ZERO
	PlayerHud.update_potion(-1)
	player.update_animation("healing")
	ended = false
	audio.stream = sound1
	audio.play()

func exit() -> void:
	animation_player.animation_finished.disconnect(animation_potion_end)
	
func process( _delta: float) -> State:
	if ended : 
		return idle
	
	return null
	
func physics(_delta: float) -> State:
	return null

func handle_input(_eventL: InputEvent) -> State:
	return null

func animation_potion_end(_animation_name: String):
	ended = true
	audio2.play()
