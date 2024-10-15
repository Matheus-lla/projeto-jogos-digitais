class_name EnemyStateWander extends EnemyState

@export var anim_name: String = "walk"
@export var walk_speed: float = 20.0
@export_category("AI")
@export var state_animation_duration: float = 0.5
@export var state_cicles_min: int = 1
@export var state_cicles_max: int = 4
@export var next_state: EnemyState

var timer: float = 0.0
var direction: Vector2

func init() -> void:
	pass

func enter() -> void:
	timer = randi_range(state_cicles_min, state_cicles_max) * state_animation_duration
	direction = enemy.DIR_4[randi_range(0, 3)]
	enemy.velocity = direction * walk_speed
	enemy.set_direction(direction)
	enemy.update_animation(anim_name)
	pass

func exit() -> void:
	pass
	
func process( delta: float) -> EnemyState:
	timer -= delta
	
	if timer <= 0:
		return next_state
		
	return null
	
func physics(_delta: float) -> EnemyState:
	return null
