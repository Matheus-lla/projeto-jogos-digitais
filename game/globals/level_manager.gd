extends Node

var current_tile_map_bounds: Array[Vector2]
signal TileMapBoundsChanged(bounds: Array[Vector2])

func changed_tile_map_bounds(bounds: Array[Vector2]) -> void:
	current_tile_map_bounds = bounds
	TileMapBoundsChanged.emit(bounds)
