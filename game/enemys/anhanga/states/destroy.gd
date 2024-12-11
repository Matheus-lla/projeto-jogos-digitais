class_name AnhangaStateDestroy extends State

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

@export var anim_name: String = "destroy"
@export var reward: int = 50
@onready var enemy_state_idle: EnemyStateIdle = $"../EnemyStateIdle"

func init() -> void:
	character.CharacterDestroyed.connect(on_destroyed)

func enter() -> void:
	character.defeated = true
	character.is_in_combat = false
	character.invulnerable = true
	character.update_animation(anim_name)
	animation_player.animation_finished.connect(on_animation_finished)
	
func on_destroyed(_hurt_box: HurtBox):
	PlayerHud.update_guarana(reward)
	state_machine.update_state(self)

func on_animation_finished(_current_animation: String):
	KillsRecord.killed(character.name)
	state_machine.update_state(enemy_state_idle)
