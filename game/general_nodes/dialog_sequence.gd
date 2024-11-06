class_name DialogSequence extends InteractArea

var dialog_items: Array[DialogItem]
@onready var animation_dialog: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	super._ready()
	
	for c in get_children():
		if c is DialogItem:
			dialog_items.append(c)

func on_area_exit(area: Area2D):
	super.on_area_exit(area)
	animation_dialog.play("hide")
	Dialog.hide_dialog()
	
func on_area_entered(area: Area2D):
	animation_dialog.play("show")
	super.on_area_entered(area)
	
func on_interection():
	super.on_interection()
	Dialog.show_dialog()
