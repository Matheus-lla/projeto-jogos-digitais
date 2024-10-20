class_name PlayerStun extends PlayerState

@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0
@export var invulnerable_duration: float = 1.0

var hurt_box: HurtBox
var direction: Vector2
var next_state: PlayerState = null
const animation_name: String = "stun"

@onready var idle: PlayerState = $"../Idle"

func init():
	player.PlayerDamaged.connect(on_player_damaged)

func enter() -> void:
	player.animation_player.animation_finished.connect(on_animation_fineshed)
	direction = player.global_position.direction_to(hurt_box.global_position)
	player.velocity = direction * - knockback_speed
	player.set_direction()
	player.update_animation(animation_name)
	player.make_invulnerable(invulnerable_duration)
	player.effect_animation_player.play("damaged")
	pass

func exit() -> void:
	next_state = null
	player.animation_player.animation_finished.disconnect(on_animation_fineshed)
	pass
	
func process(delta: float) -> PlayerState:
	player.velocity -= player.velocity * decelerate_speed * delta
	return next_state
	
func physics(_delta: float) -> PlayerState:
	return null

func on_player_damaged(_hurt_box: HurtBox):
	hurt_box = _hurt_box
	state_machine.change_state(self)
	
func on_animation_fineshed(_animation_name: String):
	next_state = idle
