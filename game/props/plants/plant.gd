class_name Plant extends Node

@onready var hit_box: HitBox = $HitBox

func _ready() -> void:
	hit_box.Damaged.connect(take_damage)

func take_damage(hurt_box: HurtBox):
	queue_free()
