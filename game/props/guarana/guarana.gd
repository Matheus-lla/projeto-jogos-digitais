extends Node2D
class_name Guarana

@onready var sprite: Sprite2D = $Sprite2D
@onready var interact_area: InteractArea = $InteractionArea

const GUARANA_EMPTY = preload("res://props/guarana/guarana_empty.png")
const GUARANA_FULL = preload("res://props/guarana/guarana_full.png")

var catch: bool = false
var trees: Array = []
var index: int = 0
var actual_guarana: Guarana

func _ready() -> void:
	interact_area.Interect.connect(on_interection)
	sprite.texture = GUARANA_FULL

func on_interection():
	if catch:
		return
		
	PlayerHud.update_guarana(3)
	sprite.texture = GUARANA_EMPTY
	catch = true

func guarana_spawm():
	catch = false
	
	if sprite:
		sprite.texture = GUARANA_FULL
