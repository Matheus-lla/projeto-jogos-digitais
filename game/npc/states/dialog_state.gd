class_name VillagerStateDialog extends VillagerState

func init() -> void:
	pass

func enter() -> void:
	print("entrou")
	villager.velocity = Vector2.ZERO
	villager.cardinal_direction = -GlobalPlayerManager.player.cardinal_direction
	villager.update_animation("idle")
	

func exit() -> void:
	pass
	
func process(_delta: float) -> VillagerState:
	return null
	
func physics(_delta: float) -> VillagerState:
	return null
