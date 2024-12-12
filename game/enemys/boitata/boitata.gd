class_name Boitata extends Character

var player : Player
var is_in_combat: bool
var defeated: bool = false
var dialog_ended = false

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var hit_box : HitBox = $HitBox
@onready var vision_area: VisionArea = $VisionArea
@onready var camera_2d: Camera2D = $Camera2D
@onready var door: StaticBody2D = $StaticBody2D
@onready var dialog_sequence: DialogSequence = $DialogSequence
@onready var portal: Portal = $Portal

func _ready():
	super._ready()
	state_machine.init( self )
	player = GlobalPlayerManager.player
	hit_box.Damaged.connect(_take_damage)
	vision_area.player_entered.connect(on_player_enter)
	vision_area.player_exited.connect(on_player_exit)
	dialog_sequence.DialogEnded.connect(on_dialog_ended)
	invulnerable = true

func on_dialog_ended():
	dialog_ended = true
	start_combat()
	dialog_sequence.DialogEnded.disconnect(on_dialog_ended)

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
		
func start_combat():		
	is_in_combat = true
	await get_tree().create_timer(0.3).timeout
	door.set_collision_layer_value(5, true)
	camera_2d.make_current()
	invulnerable = false
	
func on_player_enter():
	if defeated or not dialog_ended:
		return
		
	start_combat()

func on_player_exit():
	invulnerable = true
	is_in_combat = false
	await get_tree().create_timer(0.3).timeout
	door.set_collision_layer_value(5, false)
	player.camera.make_current()
	
