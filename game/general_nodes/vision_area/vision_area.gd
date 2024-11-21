class_name VisionArea extends Area2D

signal player_entered()
signal player_exited()

func _ready() -> void:
	body_entered.connect(_on_body_enter)
	body_exited.connect(_on_body_exit)

func _on_body_enter(_b: Node2D) -> void:
	if _b is Player:
		player_entered.emit()
	pass

func _on_body_exit(_b: Node2D) -> void:
	if _b is Player:
		player_exited.emit()
	pass
