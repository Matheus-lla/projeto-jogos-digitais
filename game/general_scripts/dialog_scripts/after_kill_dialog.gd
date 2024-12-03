extends SingleDialog 

@export var victim_name: String

func is_enabled():
	var kills = KillsRecord.kills.get_or_add(victim_name, 0)
	return kills > 0 and super.is_enabled()
