class_name Anhanga extends Character

var player : Player
var is_in_combat: bool
var defeated: bool = false
var dialog_ended = false

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var hit_box : HitBox = $HitBox
@onready var vision_area: VisionArea = $VisionArea
@onready var dialog_sequence: DialogSequence = $DialogSequence

func _ready():
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
	invulnerable = false
	
func on_player_enter():
	if defeated or not dialog_ended:
		return
		
	start_combat()

func on_player_exit():
	invulnerable = true
	is_in_combat = false
	await get_tree().create_timer(0.3).timeout
	player.camera.make_current()
	
