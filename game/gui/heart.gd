class_name Heart extends Control

@onready var sprite_2d: Sprite2D = $Sprite2D

var value: int = 2 :
	set(new_value):
		value = new_value
		update_sprite()

func update_sprite():
	sprite_2d.frame = value
