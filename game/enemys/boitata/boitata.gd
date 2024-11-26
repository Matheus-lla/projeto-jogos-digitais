class_name Boitata extends Character

var player : Player
var is_in_combat: bool
var defeated: bool = false

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var hit_box : HitBox = $HitBox
@onready var vision_area: VisionArea = $VisionArea
@onready var camera_2d: Camera2D = $Camera2D
@onready var door: StaticBody2D = $StaticBody2D

func _ready():
	state_machine.init( self )
	player = GlobalPlayerManager.player
	hit_box.Damaged.connect(_take_damage)
	vision_area.player_entered.connect(on_player_enter)
	vision_area.player_exited.connect(on_player_exit)

# Overrides default definition of _physics_process
func _physics_process(_delta: float) -> void:
	return

func update_animation(state_str: String) -> void:
	animation.play(state_str)

func _take_damage( hurt_box : HurtBox ) -> void:
	if invulnerable == true:
		return
		
	hp -= hurt_box.damage
	
	if hp <= 0:
		CharacterDestroyed.emit( hurt_box )
		return
		
	CharacterDamaged.emit( hurt_box )
		
func on_player_enter():
	is_in_combat = true
	door.set_collision_layer_value(5, true)
	camera_2d.make_current()

func on_player_exit():
	is_in_combat = false
	door.set_collision_layer_value(5, false)
	player.camera.make_current()
	
