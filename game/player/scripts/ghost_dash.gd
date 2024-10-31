class_name GhostDash extends Sprite2D

var timer: float
const GOSTH_LIFE_TIME: float = 0.2 # This value must be less than the Dash Duration

func _ready() -> void:
	global_position.y -= 9
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_ease(Tween.EASE_OUT)
	tween.finished.connect(_on_tween_finished)
	timer = GOSTH_LIFE_TIME
	
func _process(delta: float) -> void:
	timer -= delta
	
	if timer <= 0:
		queue_free()

func _on_tween_finished():
	queue_free()
