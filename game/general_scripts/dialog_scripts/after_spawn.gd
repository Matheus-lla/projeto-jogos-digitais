extends SingleDialog 

@export var required_spawn: Spawn

func is_enabled():
	return GlobalPlayerManager.player.spawn_place == required_spawn and super.is_enabled()
