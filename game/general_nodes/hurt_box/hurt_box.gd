class_name HurtBox extends Area2D

@export var damage: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(area_entrered_callback)
	pass # Replace with function body.

func area_entrered_callback(a: Area2D):
	if a is HitBox:
		a.take_damage(self)
	
	pass
