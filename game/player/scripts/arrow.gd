class_name Arrow extends CharacterBody2D

enum ArrowState {
	INACTIVE, # No arrow at all
	LOADING, # Pulling the arrow before release
	FLIGHT, # Arrow released
}

var player: Player
var state: ArrowState = ArrowState.INACTIVE
var hurt_box: HurtBox
var timer: float

const SPEED: float = 200.0
const LOADING_TIME: float = 0.35 # time to pull the arrow and released
const SCALE_FACTOR: float = 1.1

func _ready() -> void:
	# Makes the initial position of the arrow a litle bit in front of the character
	global_position = player.global_position + player.cardinal_direction * 10
	
	# Fix positioning
	if player.cardinal_direction == Vector2.LEFT || player.cardinal_direction == Vector2.RIGHT:
		global_position.y -= 10

func _physics_process(delta: float) -> void:
	if state == ArrowState.INACTIVE:
		return
		
	if state == ArrowState.LOADING:
		if timer <= 0:
			state = ArrowState.FLIGHT
			visible = true
			
		timer -= delta
		return

	move_and_slide() # Moves the arrow and check for collisions
	
	if is_on_wall():
		destroy()

func shoot(damage: int) -> void:
	hurt_box = $HurtBox
	hurt_box.damage = damage
	hurt_box.area_entered.connect(on_area_entered)
	player = GlobalPlayerManager.player
	velocity = player.cardinal_direction * SPEED
	set_rotation_from_direction(player.cardinal_direction)
	timer = LOADING_TIME
	state = ArrowState.LOADING
	visible = false
	scale *= SCALE_FACTOR

func set_rotation_from_direction(direction: Vector2):
	match direction:
		Vector2.DOWN:
			rotation_degrees = 90
		Vector2.UP:
			rotation_degrees = 270
		Vector2.LEFT:
			rotation_degrees = 180
		Vector2.RIGHT:
			rotation_degrees = 0
		_:
			rotation_degrees = 0

func on_area_entered(area: Area2D):
	if area is HitBox:
		destroy()

func destroy():
	queue_free()
	pass
