class_name EnemyStateDestroy extends State

var direction: Vector2
var damage_position: Vector2

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

@export var hurt_box: HurtBox
@export var anim_name: String = "destroy"
@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0
@export var reward: int = 1

func init() -> void:
	character.CharacterDestroyed.connect(on_destroyed)

func enter() -> void:
	character.invulnerable = true
	direction = character.global_position.direction_to(GlobalPlayerManager.player.global_position)
	character.set_direction(direction)
	character.velocity = direction * -knockback_speed;
	character.update_animation(anim_name)
	hurt_box.monitoring = false
	animation_player.animation_finished.connect(on_animation_finished)
	
func process( delta: float) -> State:
	character.velocity -= character.velocity * decelerate_speed * delta
	return null
	
func on_destroyed(_hurt_box: HurtBox):
	PlayerHud.update_guarana(reward)
	damage_position = _hurt_box.global_position
	state_machine.change_state(self)

func on_animation_finished(_current_animation: String):
	KillsRecord.killed(character.get_class())
	character.queue_free()
