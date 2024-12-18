class_name InteractArea extends Area2D

signal Interact()

func _ready() -> void:
	area_entered.connect(on_area_entered)
	area_exited.connect(on_area_exit)
	
func on_area_exit(_area: Area2D):
	GlobalPlayerManager.interact_pressed.disconnect(on_interaction)

func on_area_entered(_area: Area2D):
	GlobalPlayerManager.interact_pressed.connect(on_interaction)
	
func on_interaction():
	Interact.emit()
