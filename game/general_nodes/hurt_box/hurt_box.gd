class_name HurtBox extends Area2D

@export var damage: int = 1

func _ready() -> void:
	area_entered.connect(area_entrered_callback)

func area_entrered_callback(a: Area2D):
	if a is HitBox:
		a.take_damage(self)
