class_name BurningAttack extends CharacterBody2D

enum States {
	INACTIVE, # No attack at all
	LOADING, # Charging attack before release
	FLIGHT, # Attack released
}

var character: Character
var scale_factor: float
var state: States = States.INACTIVE
var hurt_box: HurtBox
var timer: float
var destroy_timer: float
var visible_timer: float
var player: Player

const MAX_SPEED: float = 200.0
const ACELERATION: float = 80.0
const LOADING_TIME: float = 1.325 # time to load the attack
const LIFE_TIME: float = 6 # Time that the attack will live
const VISIBLE_TIME: float = 0.5 # Time that the attack will live
const SCALE_DIF: float = 0.0001 # Time that the attack will live

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	# Makes the fire ball start from the enemy mouth
	global_position = character.global_position + Vector2(32, -170)
	velocity = Vector2.UP * 200

func start_fligth():
	state = States.FLIGHT
	visible = true

func _physics_process(delta: float) -> void:
	if state == States.INACTIVE:
		return
		
	destroy_timer -= delta
	
	if destroy_timer <= 0:
		destroy()
		
	if state == States.LOADING:
		if timer <= 0:
			start_fligth()
			
		timer -= delta
		return
		
	visible_timer -= delta
	if visible_timer <= 0:
		visible_timer = VISIBLE_TIME
		sprite_2d.visible = !sprite_2d.visible
		hurt_box.monitoring = !hurt_box.monitoring
		
	scale *= scale_factor
	scale_factor -= SCALE_DIF
	
	if velocity.length() <= MAX_SPEED:
		velocity += global_position.direction_to(player.global_position) * ACELERATION * delta
	
	move_and_slide()

func shoot(_character: Character) -> void:
	character = _character
	hurt_box = $HurtBox
	hurt_box.area_entered.connect(on_area_entered)
	timer = LOADING_TIME
	destroy_timer = LIFE_TIME
	visible_timer = VISIBLE_TIME
	state = States.LOADING
	visible = false
	player = GlobalPlayerManager.player
	scale_factor = 1.05

func on_area_entered(area: Area2D):
	if area is HitBox:
		destroy()

func destroy():
	queue_free()
