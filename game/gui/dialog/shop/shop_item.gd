class_name ShopItem extends Node

var item: Upgradable
var label: Label
var button: Button
var guarana_sprite: Sprite2D

func _init(_item: Upgradable, _label: Label, _button: Button, _guarana_sprite: Sprite2D) -> void:
	item = _item
	label = _label
	button = _button
	guarana_sprite = _guarana_sprite
	button.pressed.connect(on_pressed)
	update_ui()
	
func cost_str():
	var cost = str(item.upgrade_cost())
		
	for i in 3 - cost.length():
		cost = "" + cost
		
	return cost + " x "

func update_ui():
	if item.max():
		label.text = ""
		button.disabled = true
		guarana_sprite.visible = false
		return
		
	if item.upgrade_cost() > PlayerHud.guarana:
		label.text = cost_str()
		button.disabled = true
		return
		
	label.text = cost_str()
	button.disabled = false
	
func on_pressed():
	item.upgrade()
