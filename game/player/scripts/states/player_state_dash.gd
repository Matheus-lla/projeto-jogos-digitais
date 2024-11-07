class_name Dash extends PlayerState

@onready var dash_cool_down: Timer = $DashCoolDown
@onready var ghost_timer: Timer = $GhostTimer
@onready var audio: AudioStreamPlayer2D = $"../../Audio"

@export var move_speed: float
@export var next_state: PlayerState
@export var dash_duration: float
@export var sound: AudioStream

var animation_name = "dash"
var timer: float = 0
var dash_direction: Vector2
var enabled: bool = true
var skip: bool = false
var ghost_scene = preload("res://player/GhostDash.tscn")
var sprite

func init():
	dash_cool_down.timeout.connect(on_dash_cool_down)

func enter() -> void:
	if !enabled:
		skip = true
		return
	
	set_dash_ghost_efect(0.4, true)
	
	enabled = false
	dash_cool_down.start()
	timer = dash_duration
	ghost_timer.start()

	
	dash_direction = player.direction
	if dash_direction == Vector2.ZERO:
		dash_direction = player.cardinal_direction
		
	dash_direction = player.faced_direction()
	player.make_invulnerable(2*dash_duration)
	player.update_animation(animation_name)
	
	audio.stream = sound
	audio.pitch_scale = 1.5

	audio.play()
	
	instance_ghost()
	
func instance_ghost():
	var ghost: GhostDash = ghost_scene.instantiate()
	sprite = player.sprite
	
	ghost.global_position = player.global_position
	ghost.position = player.position + dash_direction * 5
	ghost.texture = sprite.texture
	ghost.hframes = sprite.hframes
	ghost.vframes = sprite.vframes
	ghost.frame = sprite.frame
	ghost.flip_h = sprite.flip_h
	get_tree().root.add_child(ghost)

	
func set_dash_ghost_efect(weight: float, white: bool):
	if player.sprite.material == null:
		player.sprite.material = load("res://player/scripts/GhostDash.tres")
	
	if player.sprite.material is ShaderMaterial:
		player.sprite.material.set("parameters/mix_weight", weight)
		player.sprite.material.set("parameters/whiten", white)
		player.sprite.material.set("parameters/mix_alpha", 0.3)
		
func exit() -> void:
	set_dash_ghost_efect(1.0, false)
	ghost_timer.stop()
	audio.pitch_scale = 1
	
func process(delta: float) -> PlayerState:
	if skip:
		return next_state
		
	timer -= delta
	player.direction = dash_direction
	
	if timer <= 0:
		return next_state
	
	player.velocity = move_speed * player.direction
	
	return null
	
func physics(_delta: float) -> PlayerState:
	return null

func handle_input(_event: InputEvent) -> PlayerState:
	return null
	
func on_dash_cool_down():
	enabled = true
	skip = false
	exit()


func _on_ghost_timer_timeout() -> void:
	instance_ghost()
