class_name GhostDash extends Sprite2D

const GOSTH_LIFE_TIME: float = 0.5 # This value must be less than the Dash Duration
var timer: float = GOSTH_LIFE_TIME
	
func _ready() -> void:
	global_position = GlobalPlayerManager.player.global_position
	global_position.y -= 9
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.4)
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_interval(4.1)
	tween.tween_callback(_on_tween_finished)

	
func _process(delta: float) -> void:
	timer -= delta

	if timer <= 0:
		queue_free()

func _on_tween_finished():
	queue_free()
