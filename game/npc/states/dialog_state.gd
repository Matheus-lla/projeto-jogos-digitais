class_name NPCDialog extends State

func enter() -> void:
	character.velocity = Vector2.ZERO
	character.cardinal_direction = -GlobalPlayerManager.player.cardinal_direction
	character.update_animation("idle")
