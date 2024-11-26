class_name BoitataStateStun extends State

var animation_finished: bool = false
@export var anim_name: String = "stun"

func init() -> void:
	character.CharacterDamaged.connect(on_damaged)

func enter() -> void:
	character.invulnerable = true
	animation_finished = false
	character.update_animation(anim_name)
	character.animation_player.animation_finished.connect(on_animation_finished)
	
func exit() -> void:
	character.invulnerable = false
	character.animation_player.animation_finished.disconnect(on_animation_finished)
	
func process( delta: float) -> State:
	if animation_finished:
		return self
		
	return null
	
func on_damaged(hurt_box: HurtBox):
	state_machine.update_state(self)

func on_animation_finished(_current_animation: String):
	animation_finished = true
