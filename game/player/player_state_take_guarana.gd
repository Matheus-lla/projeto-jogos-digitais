extends PlayerState
class_name TakeGuarana




func _ready():
	pass

func init():
	pass

func enter() -> void:
	print("Entrei no take_guarana")
	print(player.in_guarana)
	if (player.in_guarana):
		print("dentro")
		

func exit() -> void:
	pass
	
func process( _delta: float) -> PlayerState:
	return null
	
func physics(_delta: float) -> PlayerState:
	return null

func handle_input(_eventL: InputEvent) -> PlayerState:
	return null
