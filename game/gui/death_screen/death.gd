class_name Death extends Node

@onready var button: Button = $Button

signal restart()

func _ready() -> void:
	button.pressed.connect(on_button_pressed)
	
func on_button_pressed():
	restart.emit()
