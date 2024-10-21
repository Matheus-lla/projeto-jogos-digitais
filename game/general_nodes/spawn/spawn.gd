class_name Spawn extends Node2D

@onready var interect_area: Area2D = $Area2D
@onready var label: Label = $Label

func _ready() -> void:
	interect_area.area_entered.connect(on_area_entered)
	interect_area.area_exited.connect(on_area_exit)

func on_area_entered(_area: Area2D):
	GlobalPlayerManager.interact_pressed.connect(on_interection)
	
func on_interection():
	GlobalPlayerManager.player.spawn_place = self
	label.visible = true
	await get_tree().create_timer(2.0).timeout
	label.visible = false
	
	
func on_area_exit(_area: Area2D):
	GlobalPlayerManager.interact_pressed.disconnect(on_interection)
