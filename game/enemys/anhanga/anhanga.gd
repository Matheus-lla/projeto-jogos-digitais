class_name Anhanga extends Character

var player : Player
var is_in_combat: bool
var defeated: bool = false
var dialog_ended = false
var chase_speed: float
var dialog_count = 0

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var hit_box : HitBox = $HitBox
@onready var vision_area: VisionArea = $VisionArea
@onready var dialog_sequence: DialogSequence = $DialogSequence
@onready var static_hurt_box: HurtBox = $StaticHurtBox
@onready var enemy_spawn: EnemySpawn = $EnemySpawn

func _ready():
	state_machine.init( self )
	player = GlobalPlayerManager.player
	hit_box.Damaged.connect(_take_damage)
	vision_area.player_entered.connect(on_player_enter)
	vision_area.player_exited.connect(on_player_exit)
	dialog_sequence.DialogEnded.connect(on_dialog_ended)
	enemy_spawn.parent = get_parent()
	invulnerable = true
	
func _process(_delta: float) -> void:
	var distance : Vector2 = player.global_position - global_position
	chase_speed = distance.length() * 0.75
	
	if chase_speed > 150.0:
		chase_speed = 150.0
	
	if chase_speed <= 6.0:
		chase_speed = 0.0

func on_dialog_ended():
	dialog_count += 1
	
	if dialog_count == 1:
		dialog_ended = true
		start_combat()
		return
	
	if dialog_count == 2:
		dialog_sequence.DialogEnded.disconnect(on_dialog_ended)
		queue_free()

func _take_damage( hurt_box : HurtBox ) -> void:
	if invulnerable == true:
		return
		
	hp -= hurt_box.damage
	
	if hp <= 0:
		enemy_spawn.stop()
		CharacterDestroyed.emit( hurt_box )
		return
		
	CharacterDamaged.emit( hurt_box )
		
func start_combat():
	static_hurt_box.monitoring = true
	is_in_combat = true
	await get_tree().create_timer(0.3).timeout
	invulnerable = false
	enemy_spawn.start()
	
func on_player_enter():
	if defeated or not dialog_ended:
		return
		
	start_combat()

func on_player_exit():
	static_hurt_box.monitoring = false
	invulnerable = true
	is_in_combat = false
	await get_tree().create_timer(0.3).timeout
	player.camera.make_current()
	enemy_spawn.stop()
	
