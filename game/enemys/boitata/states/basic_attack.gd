extends State

@export var next_state: State
@export var animation_name: String = "basic_attack"

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

var finished: bool

const AttackCene = preload("res://enemys/boitata/basic_attack/basic_attack.tscn")

func enter():
	finished = false
	character.update_animation(animation_name)
	animation_player.animation_finished.connect(on_animation_finished)
	var attack = AttackCene.instantiate() as BasicAttack
	attack.shoot(character)
	character.add_sibling(attack)

func exit():
	animation_player.animation_finished.disconnect(on_animation_finished)
	
func process(_delta: float) -> State:
	if finished:
		return self
		
	return null

func on_animation_finished(_animation_name: String):
	finished = true
