class_name VillagerStateDialog extends VillagerState

func init() -> void:
	pass

func enter() -> void:
	villager.velocity = Vector2.ZERO
	villager.direction = -GlobalPlayerManager.player.direction

func exit() -> void:
	pass
	
func process(_delta: float) -> VillagerState:
	return null
	
func physics(_delta: float) -> VillagerState:
	return null
