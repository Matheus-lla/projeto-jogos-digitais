class_name Plant extends Node

@onready var hit_box: HitBox = $HitBox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hit_box.Damaged.connect(take_damage)
	pass # Replace with function body.

func take_damage(_damage: int) -> void:
	queue_free()
