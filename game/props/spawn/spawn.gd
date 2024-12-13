class_name Spawn extends Node2D

@onready var interact_area: InteractArea = $InteractionArea
@onready var label: Label = $Label
@onready var fire: Fire = $Fire

func _ready() -> void:
	interact_area.Interact.connect(on_interaction)
	fire.process_mode = Node.PROCESS_MODE_DISABLED
	
func on_interaction():
	fire.process_mode = Node.PROCESS_MODE_INHERIT
	fire.start(fire.global_position, INF)
	GlobalPlayerManager.player.spawn_place = self
	#GlobalPlayerManager.player.spawn(false)
	label.visible = true
	await get_tree().create_timer(2.0).timeout
	label.visible = false
