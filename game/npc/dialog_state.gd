class_name VillagerStateDialog extends VillagerState

func init() -> void:
	pass

func enter() -> void:
	Dialog.show_dialog()
	villager.velocity = Vector2.ZERO
	villager.direction = -GlobalPlayerManager.player.direction

func exit() -> void:
	Dialog.hide_dialog()
	
func process(_delta: float) -> VillagerState:
	return null
	
func physics(_delta: float) -> VillagerState:
	return null
