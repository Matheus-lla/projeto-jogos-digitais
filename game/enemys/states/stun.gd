class_name EnemyStateStun extends State

var direction: Vector2
var animation_finished: bool = false
var damage_position: Vector2

@export var anim_name: String = "stun"
@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0
@export_category("AI")
@export var next_state: State

func init() -> void:
	character.CharacterDamaged.connect(on_damaged)

func enter() -> void:
	character.invulnerable = true
	animation_finished = false
	
	direction = character.global_position.direction_to(damage_position)
	character.set_direction(direction)
	character.velocity = direction * -knockback_speed;
	character.update_animation(anim_name)
	character.animation_player.animation_finished.connect(on_animation_finished)
	
func exit() -> void:
	character.invulnerable = false
	character.animation_player.animation_finished.disconnect(on_animation_finished)
	pass
	
func process( delta: float) -> State:
	if animation_finished:
		return next_state
		
	character.velocity -= character.velocity * decelerate_speed * delta
	return null
	
func on_damaged(hurt_box: HurtBox):
	damage_position = hurt_box.global_position
	state_machine.change_state(self)

func on_animation_finished(_current_animation: String):
	animation_finished = true
