extends Node2D
class_name Guarana

@onready var sprite: Sprite2D = $Sprite2D
@onready var interect_area: Area2D = $InteractionArea

const GUARANA_EMPTY = preload("res://props/guarana/guarana_empty.png")
const GUARANA_FULL = preload("res://props/guarana/guarana_full.png")

var catch: bool = false
var trees: Array = []
var index: int = 0
var actual_guarana: Guarana

func _ready() -> void:
	interect_area.area_entered.connect(on_area_entered)
	interect_area.area_exited.connect(on_area_exit)

func on_area_entered(_area: Area2D):
	GlobalPlayerManager.interact_pressed.connect(on_interection)
	
func on_interection():
	if (!catch):
		actual_guarana = GlobalPlayerManager.player.guarana_trees[index]
		actual_guarana = self
		PlayerHud.update_guarana(3)
		sprite.texture = GUARANA_EMPTY
		actual_guarana.catch = true
		index += 1
		
	
func on_area_exit(_area: Area2D):
	GlobalPlayerManager.interact_pressed.disconnect(on_interection)
	
func guarana_spawm():
	catch = false
	if sprite:  
		sprite.texture = GUARANA_FULL
	else:
		print("Erro: sprite_2d não foi inicializado corretamente no guaraná.")
		
	
