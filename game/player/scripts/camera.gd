class_name Camera extends Camera2D

func _ready() -> void:
	LevelManager.TileMapBoundsChanged.connect(update_limits)
	update_limits(LevelManager.current_tile_map_bounds)

func update_limits(bounds: Array[Vector2]) -> void:
	if bounds.size() < 2:
		return
	
	limit_left = int(bounds[0].x)
	limit_top = int(bounds[0].y)
	limit_right = int(bounds[1].x)
	limit_bottom = int(bounds[1].y)
