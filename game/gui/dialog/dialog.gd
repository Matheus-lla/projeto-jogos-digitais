extends CanvasLayer
@onready var ui: Control = $UI
@onready var name_label: Label = $UI/Label
@onready var rich_text_label: RichTextLabel = $UI/PanelContainer/RichTextLabel
@onready var button_label: Label = $UI/DialogProgress/Label
@onready var animation_player: AnimationPlayer = $UI/DialogProgress/AnimationPlayer
@onready var dialog_progress: PanelContainer = $UI/DialogProgress

var is_active: bool

func _ready() -> void:
	hide_dialog()

func show_dialog(character_name: String, text: String, button_text: String):
	is_active = true
	ui.visible = true
	ui.process_mode = Node.PROCESS_MODE_ALWAYS
	name_label.text = character_name
	rich_text_label.text = text
	button_label.text = button_text
	#get_tree().paused = true
	

func hide_dialog():
	is_active = false
	ui.visible = false
	ui.process_mode = Node.PROCESS_MODE_DISABLED
	#get_tree().paused = false
	
