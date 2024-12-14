extends CanvasLayer

var paused: bool
@onready var button: Button = $Button
@onready var button_2: Button = $Button2

func _ready() -> void:
	paused = false
	visible = false
	button.pressed.connect(on_button_pressed)
	button_2.pressed.connect(on_exit_pressed)
	
func on_exit_pressed():
	get_tree().quit()

func on_button_pressed():
	unpause()

func pause():
	paused = true
	visible = true
	get_tree().paused = true

func unpause():
	paused = false
	visible = false
	get_tree().paused = false
	
func switch():
	if paused:
		unpause()
	else:
		pause()
