extends CanvasLayer

@onready var ui: Control = $UI
@onready var name_label: Label = $UI/Label

func _ready() -> void:
	hide_shop()

func show_shop(character_name: String):
	ui.visible = true
	ui.process_mode = Node.PROCESS_MODE_ALWAYS
	name_label.text = character_name
	#get_tree().paused = true
	
func hide_shop():
	ui.visible = false
	ui.process_mode = Node.PROCESS_MODE_DISABLED
	#get_tree().paused = false
	
