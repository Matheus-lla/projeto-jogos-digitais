class_name HealthPotion extends Control

@onready var sprite2D : Sprite2D = $Antidote

var value: int = 1 :
	set(new_value):
		value = new_value
		
# Called when the node enters the scene tree for the first time.
func use(player: Player) -> void:
	player.increase_health()
	
func can_be_use(player: Player) -> bool:
	return player.hp < player.max_hp
	
