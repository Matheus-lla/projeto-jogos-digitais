class_name EnemyDestroy extends EnemyState

var direction: Vector2
var damage_position: Vector2


@onready var state_machine: EnemyStateMachine = $".."
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

@export var anim_name: String = "destroy"
@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0

func init() -> void:
	enemy.EnemyDestroyed.connect(on_enemy_destroyed)

func enter() -> void:
	enemy.invulnerable = true
	direction = enemy.global_position.direction_to(GlobalPlayerManager.player.global_position)
	enemy.set_direction(direction)
	enemy.velocity = direction * -knockback_speed;
	enemy.update_animation(anim_name)
	animation_player.animation_finished.connect(on_animation_finished)
	
func exit() -> void:
	pass
	
func process( delta: float) -> EnemyState:
	enemy.velocity -= enemy.velocity * decelerate_speed * delta
	return null
	
func physics(_delta: float) -> EnemyState:
	return null

func on_enemy_destroyed(hurt_box: HurtBox):
	damage_position = hurt_box.global_position
	state_machine.change_state(self)

func on_animation_finished(_current_animation: String):
	enemy.queue_free()
