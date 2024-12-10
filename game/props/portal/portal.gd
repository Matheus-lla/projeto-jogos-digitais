class_name Portal extends Node2D

@export var target_portal: Portal

@onready var interact_area: InteractArea = $InteractArea

func _ready() -> void:
	interact_area.Interact.connect(on_interaction)

func on_interaction():
	GlobalPlayerManager.player.global_position = target_portal.global_position
