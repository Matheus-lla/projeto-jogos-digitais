extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var chilren = Array()
	
	for child in get_children():
		await child.ready
		chilren.append(child)
		
	print(chilren.size())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	#print(process_mode)
	#print(Time.get_datetime_dict_from_system())
