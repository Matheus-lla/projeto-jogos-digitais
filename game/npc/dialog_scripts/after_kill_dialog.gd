extends SingleDialog 

func is_enabled():
	return GlobalPlayerManager.player.kills > 0 and super.is_enabled()
