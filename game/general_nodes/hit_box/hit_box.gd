class_name HitBox extends Area2D

signal Damaged(damage: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func take_damage(damage: int) -> void:
	Damaged.emit(damage)
