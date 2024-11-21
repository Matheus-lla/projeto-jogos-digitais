class_name VisionArea extends Area2D

signal player_entered()
signal player_exited()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_enter)
	body_exited.connect(_on_body_exit)
	
	var p = get_parent()
	if p is Character:
		p.DirectionChanged.connect(_on_direction_change)

func _on_body_enter(_b: Node2D) -> void:
	if _b is Player:
		player_entered.emit()
	pass

func _on_body_exit(_b: Node2D) -> void:
	if _b is Player:
		player_exited.emit()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_direction_change(new_direction : Vector2) -> void:
	match new_direction:
		Vector2.DOWN:
			rotation_degrees = 0
		Vector2.UP:
			rotation_degrees = 100
		Vector2.LEFT:
			rotation_degrees = 90
		Vector2.RIGHT:
			rotation_degrees = 0
		_:
			rotation_degrees = 0
	pass
