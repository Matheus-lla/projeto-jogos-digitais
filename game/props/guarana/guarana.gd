extends Node2D
class_name Guarana

@onready var interact_area: InteractArea = $InteractionArea

@onready var full_sprite: Sprite2D = $FullSprite
@onready var empty_sprite: Sprite2D = $EmptySprite
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var catch: bool = false
var trees: Array = []
var index: int = 0
var actual_guarana: Guarana

func _ready() -> void:
	interact_area.Interact.connect(on_interaction)
	update_sprite()

func update_sprite():
	full_sprite.visible = !catch
	empty_sprite.visible = catch

func on_interaction():
	if catch:
		return
	
	audio_stream_player_2d.play()
	PlayerHud.update_guarana(5)
	catch = true
	update_sprite()

func guarana_spawm():
	catch = false
