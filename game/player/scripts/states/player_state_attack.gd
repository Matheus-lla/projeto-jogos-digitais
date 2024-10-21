class_name Attack extends PlayerState

var attacking: bool = false
@onready var attack_animation: AnimationPlayer = $"../../AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var idle: PlayerState = $"../Idle"
@onready var walk: PlayerState = $"../Walk"
@onready var hurt_box: HurtBox = %MeleeHurtBox
@export var attack_sound: AudioStream
@export_range(1, 20, 0.5) var decelerate_speed: float = 10

func init():
	pass

func enter() -> void:
	player.update_animation("spear_attack")
	#effect_animation.play("spear_attack_" + player.animation_direction())
	attack_animation.animation_finished.connect(end_attack)
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	attacking = true
	await get_tree().create_timer(0.075).timeout
	hurt_box.monitoring = true
	pass

func exit() -> void:
	attack_animation.animation_finished.disconnect(end_attack)
	attacking = false
	hurt_box.monitoring = false
	pass
	
func end_attack(_new_animation_name: String):
	attacking = false
	
func process( delta: float) -> PlayerState:	
	player.velocity -= player.velocity * decelerate_speed * delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	
	return null
	
func physics(_delta: float) -> PlayerState:
	return null

func handle_input(_eventL: InputEvent) -> PlayerState:
	return null
