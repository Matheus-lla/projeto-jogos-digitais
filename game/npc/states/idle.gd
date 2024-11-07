class_name VillagerStateIdle extends VillagerState

@export var anim_name: String = "idle"
@export_category("AI")
@export var state_duration_min: float = 0.5
@export var state_duration_max: float = 1.5
@export var next_state: VillagerState

var timer: float = 0.0

func init() -> void:
	pass

func enter() -> void:
	villager.velocity = Vector2.ZERO
	timer = randf_range(state_duration_min, state_duration_max)
	villager.update_animation(anim_name)

func exit() -> void:
	pass
	
func process( delta: float) -> VillagerState:
	timer -= delta
	
	if timer <= 0:
		return next_state
		
	return null
	
func physics(_delta: float) -> VillagerState:
	return null
