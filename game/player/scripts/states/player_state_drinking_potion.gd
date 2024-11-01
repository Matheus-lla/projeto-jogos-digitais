class_name DrinkingPotion extends PlayerState

@onready var idle: Idle = $"../Idle"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

var potion_health: int = 2
var ended: bool

func init():
	pass

func enter() -> void:
	animation_player.animation_finished.connect(animation_potion_end)
	if (PlayerHud.potions <= 0 || player.hp == player.max_hp):
		ended = true
		return
		
	player.update_hp(potion_health)
	player.velocity = Vector2.ZERO
	
	PlayerHud.update_potion(-1)
	player.update_animation("healing")
	ended = false
	

func exit() -> void:
	animation_player.animation_finished.disconnect(animation_potion_end)
	
func process( _delta: float) -> PlayerState:
	if ended : 
		return idle
	
	return null
	
func physics(_delta: float) -> PlayerState:
	return null

func handle_input(_eventL: InputEvent) -> PlayerState:
	return null

func animation_potion_end(_animation_name: String):
	ended = true
