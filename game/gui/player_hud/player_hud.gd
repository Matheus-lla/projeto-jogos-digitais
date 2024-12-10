extends CanvasLayer

@onready var label: Label = $Control/Label
@onready var antidote: Sprite2D = $Control/Antidote
@onready var guarana_label: Label = $Control/GuaranaLabel

const POTION_FULL = preload("res://gui/player_hud/potion/potion.png")
const POTION_HALF = preload("res://gui/player_hud/potion/potion_half.png")
const POTION_ALMOST_EMPTY = preload("res://gui/player_hud/potion/potion_almost_empty.png")
const EMPTY = preload("res://gui/player_hud/potion/empty.png")

var hearts: Array[Heart] = []
var max_potion: int = 2
var potions: int
var guarana: int

func _ready() -> void:
	for child in $Control/HFlowContainer.get_children():
		if child is Heart:
			child.visible = false
			hearts.append(child)

func update_heart(index: int, hp: int):
	var value: int = clampi(hp - index * 2, 0, 2)
	hearts[index].value = value

func update_potion(_delta: int):
	potions = clampi(potions + _delta, 0, max_potion)
	label.text = "x" + str(potions) 
	var relative_potions = float(potions) / float(max_potion)
		
	if relative_potions == 0.0:
		antidote.texture = EMPTY
	elif relative_potions < 0.5:
		antidote.texture = POTION_ALMOST_EMPTY
	elif relative_potions < 1.0:
		antidote.texture = POTION_HALF
	else:
		antidote.texture = POTION_FULL

func update_max_hp(max_hp: int):
	var heart_count: int = roundi(max_hp / 2)
	
	for i in hearts.size():
		if i < heart_count:
			hearts[i].visible = true
		else:
			hearts[i].visible = false

func update_hp(hp: int, max_hp: int):
	update_max_hp(max_hp)
	
	for i in max_hp:
		update_heart(i, hp)
		

func update_guarana(_delta: int):
	if guarana + _delta < 0:
		return
		
	guarana += _delta
	guarana_label.text = "x" + str(guarana) 
	
	
	
	
	
