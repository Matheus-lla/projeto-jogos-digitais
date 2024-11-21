extends Node2D

@onready var character: Character = $".."

func _ready() -> void:
	character.DirectionChanged.connect(update_rotation)

func update_rotation(new_direction: Vector2):
	match new_direction:
		Vector2.DOWN:
			rotation_degrees = 0
		Vector2.UP:
			rotation_degrees = 180
		Vector2.LEFT:
			rotation_degrees = 90
		Vector2.RIGHT:
			rotation_degrees = -90
		_:
			rotation_degrees = 0
