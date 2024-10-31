extends Sprite2D


func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_ease(Tween.EASE_OUT)
	tween.connect("fineshed", _on_tween_finished())
	
func _on_tween_finished():
	queue_free()
