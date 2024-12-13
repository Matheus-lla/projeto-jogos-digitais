class_name MusicArea extends Node

@onready var area_2d: Area2D = $Area2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@export var sound_track: AudioStream

var inside: bool
var player: Player

func _ready() -> void:
	area_2d.area_entered.connect(on_area_entered)
	area_2d.area_exited.connect(on_area_exited)
	
func on_area_exited(_area: Area2D):
	audio_stream_player.stop()

func on_area_entered(_area: Area2D):
	audio_stream_player.play()
	
func on_finished():
	audio_stream_player.play()
