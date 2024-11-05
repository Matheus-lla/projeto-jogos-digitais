extends CanvasLayer
@onready var ui: Control = $UI

var is_active: bool

func _ready() -> void:
	hide_dialog()

func show_dialog():
	is_active = true
	ui.visible = true
	ui.process_mode = Node.PROCESS_MODE_ALWAYS
	#get_tree().paused = true
	

func hide_dialog():
	is_active = false
	ui.visible = false
	ui.process_mode = Node.PROCESS_MODE_DISABLED
	#get_tree().paused = false

func _unhandled_input(event: InputEvent) -> void:
	if !is_active:
		return
		
	
