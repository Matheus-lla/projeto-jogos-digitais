class_name Attack extends State

var attacking: bool = false
var timer: float

const ANIMATION_CANCEL_TIME = 0.5

@onready var attack_animation: AnimationPlayer = $"../../AnimationPlayer"
@onready var idle: State = $"../Idle"
@onready var walk: State = $"../Walk"
@onready var audio: AudioStreamPlayer2D = $"../../Audio"
@onready var hurt_box: HurtBox = $"../../MeleeHurtBox"

@export var attack_sound: AudioStream
@export_range(1, 20, 0.5) var decelerate_speed: float = 10

var old_sound: float

func enter() -> void:
	timer = ANIMATION_CANCEL_TIME
	player.update_animation("spear_attack")
	attack_animation.animation_finished.connect(end_attack)
	audio.stream = attack_sound
	old_sound = audio.volume_db
	audio.volume_db = 10
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	attacking = true
	await get_tree().create_timer(0.075).timeout
	hurt_box.monitoring = true

func exit() -> void:
	audio.volume_db = old_sound
	attack_animation.animation_finished.disconnect(end_attack)
	attacking = false
	hurt_box.monitoring = false
	
func end_attack(_new_animation_name: String):
	attacking = false

func process( delta: float) -> State:
	timer -= delta
	
	if timer <= 0 and player.direction != Vector2.ZERO:
		return walk
	
	player.velocity -= player.velocity * decelerate_speed * delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	
	return null
