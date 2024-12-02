class_name Spawn extends Node2D

@onready var interact_area: InteractArea = $InteractionArea
@onready var label: Label = $Label

func _ready() -> void:
	interact_area.Interact.connect(on_interaction)
	
func on_interaction():
	GlobalPlayerManager.player.spawn_place = self
	label.visible = true
	await get_tree().create_timer(2.0).timeout
	label.visible = false
