extends Node2D
class_name Guarana

@onready var sprite: Sprite2D = $Sprite2D
@onready var interact_area: InteractArea = $InteractionArea

@onready var full_sprite: Sprite2D = $FullSprite
@onready var empty_sprite: Sprite2D = $EmptySprite

var catch: bool = false
var trees: Array = []
var index: int = 0
var actual_guarana: Guarana

func _ready() -> void:
	interact_area.Interect.connect(on_interection)
	update_sprite()

func update_sprite():
	full_sprite.visible = !catch
	empty_sprite.visible = catch

func on_interection():
	if catch:
		return
		
	PlayerHud.update_guarana(3)
	catch = true
	update_sprite()

func guarana_spawm():
	catch = false
