class_name Dash extends PlayerState

@onready var dash_cool_down: Timer = $DashCoolDown
@onready var ghost_timer: Timer = $GhostTimer

@export var move_speed: float
@export var next_state: PlayerState
@export var dash_duration: float

var animation_name = "walking"
var timer: float = 0
var dash_direction: Vector2
var enabled: bool = true
var skip: bool = false
var ghost_scene = preload("res://player/scripts/GhostDash.tscn")
var sprite

func init():
	dash_cool_down.timeout.connect(on_dash_cool_down)

func enter() -> void:
	if !enabled:
		skip = true
		return
	
	enabled = false
	dash_cool_down.start()
	timer = dash_duration
	ghost_timer.start()
	
	dash_direction = player.direction
	if dash_direction == Vector2.ZERO:
		dash_direction = player.cardinal_direction
		
	player.make_invulnerable(2*dash_duration)
	player.update_animation(animation_name)
	
	instance_ghost()
	
func instance_ghost():
	var ghost: Sprite2D = ghost_scene.instantiate()
	sprite = player.sprite
	
	ghost.global_position = player.global_position
	ghost.position = player.position
	ghost.texture = sprite.texture
	ghost.hframes = sprite.hframes
	ghost.vframes = sprite.vframes
	ghost.frame = sprite.frame
	ghost.flip_h = sprite.flip_h
	
	
	get_tree().root.add_child(ghost)
	
	
func exit() -> void:
	ghost_timer.stop()
	
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
