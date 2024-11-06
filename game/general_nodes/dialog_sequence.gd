class_name DialogSequence extends InteractArea

var dialog_items: Array[DialogItem]
var dialog: DialogItem
var next_dialog: DialogItem


@onready var animation_dialog: AnimationPlayer = $AnimationPlayer

@export var character_name: String

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

func on_area_exit(area: Area2D):
	super.on_area_exit(area)
	animation_dialog.play("hide")
	Dialog.hide_dialog()
	
func on_area_entered(area: Area2D):
	animation_dialog.play("show")
	super.on_area_entered(area)
	
func on_interection():
	super.on_interection()
	
	dialog = next_dialog
	
	if !dialog:
		return
	
	print("leu")
	dialog.read += 1
	next_dialog = get_next_dialog()
	var button_text = "Next" if next_dialog else "End"
	if !next_dialog:
		Dialog.dialog_progress.self_modulate = Color.ORANGE_RED
	Dialog.show_dialog(character_name, dialog.text, button_text)
