class_name DialogSequence extends 

var dialog_items: Array[DialogItem]

func _ready() -> void:
	for c in get_children():
		if c is DialogItem:
			dialog_items.append(c)
