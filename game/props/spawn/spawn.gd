class_name Spawn extends Node2D

@onready var interect_area: InteractArea = $InteractionArea
@onready var label: Label = $Label

func _ready() -> void:
	interect_area.Interect.connect(on_interection)
	
func on_interection():
	GlobalPlayerManager.player.spawn_place = self
	label.visible = true
	await get_tree().create_timer(2.0).timeout
	label.visible = false
