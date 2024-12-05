extends SingleDialog 

@export var required_quantity: int

func is_enabled():
	return PlayerHud.guarana >= required_quantity and super.is_enabled()
