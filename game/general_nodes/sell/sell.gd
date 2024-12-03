class_name Sell extends InteractArea

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var character_name: String

func _ready() -> void:
	super._ready()

func on_area_exit(area: Area2D):
	super.on_area_exit(area)
	animation_player.play("hide")
	Shop.hide_shop()
	
func on_area_entered(area: Area2D):
	super.on_area_entered(area)
	animation_player.play("show")
	
func on_interaction():
	super.on_interaction()
	
	if Dialog.ui.visible:
		return
	
	Shop.show_shop(character_name)
