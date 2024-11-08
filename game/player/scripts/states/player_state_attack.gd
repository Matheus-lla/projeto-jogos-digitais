class_name Attack extends State

var attacking: bool = false
@onready var attack_animation: AnimationPlayer = $"../../AnimationPlayer"
@onready var idle: State = $"../Idle"
@onready var walk: State = $"../Walk"
@onready var hurt_box: HurtBox = $"../../MeleeHurtBox"
@onready var audio: AudioStreamPlayer2D = $"../../Audio"

@export var attack_sound: AudioStream
@export_range(1, 20, 0.5) var decelerate_speed: float = 10

func init():
	pass

func enter() -> void:
	player.update_animation("spear_attack")
	attack_animation.animation_finished.connect(end_attack)
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	attacking = true
	await get_tree().create_timer(0.075).timeout
	hurt_box.monitoring = true

func exit() -> void:
	attack_animation.animation_finished.disconnect(end_attack)
	attacking = false
	hurt_box.monitoring = false
	
func end_attack(_new_animation_name: String):
	attacking = false
	
func process( delta: float) -> State:	
	player.velocity -= player.velocity * decelerate_speed * delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	
	return null
	
func physics(_delta: float) -> State:
	return null

func handle_input(_eventL: InputEvent) -> State:
	return null
