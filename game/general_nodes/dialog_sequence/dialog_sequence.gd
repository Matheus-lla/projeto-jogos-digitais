class_name DialogSequence extends InteractArea

signal DialogEnded()

var dialog_items: Array[DialogItem]
var next_dialog: DialogItem
var icon_up: bool = false

@onready var animation_dialog: AnimationPlayer = $AnimationPlayer

@export var character_name: String
@export var character_picture: Texture2D

func _ready() -> void:
	super._ready()
	
	for c in get_children():
		if c is DialogItem:
			dialog_items.append(c)
			
	next_dialog = get_next_dialog()
			
func get_next_dialog() -> DialogItem:
	for dialog in dialog_items:
		if dialog.is_enabled():
			return dialog
			
	return null
	
func end_dialog():
	if Dialog.ui.visible:
		DialogEnded.emit()
		Dialog.hide_dialog()
		
	if icon_up:
		animation_dialog.play("hide")
		
	icon_up = false

func on_area_exit(area: Area2D):
	super.on_area_exit(area)
	end_dialog()
	
func on_area_entered(area: Area2D):
	super.on_area_entered(area)
	
	if get_next_dialog():
		icon_up = true
		animation_dialog.play("show")
	
func use_dialog(dialog: DialogItem):
	dialog.read += 1
	
func on_interaction():
	super.on_interaction()
	
	var dialog = get_next_dialog()
	
	if !dialog:
		end_dialog()
		return
	
	# Closes infinity reapeat dialog
	if Dialog.ui.visible and dialog.name == "DialogItem":
		end_dialog()
		return
		
	Dialog.show_dialog(character_name, dialog.text, character_picture)
	use_dialog(dialog)
