class_name BasicAttack extends CharacterBody2D

enum States {
	INACTIVE, # No attack at all
	LOADING, # Charging attack before release
	FLIGHT, # Attack released
}

var character: Character
var state: States = States.INACTIVE
var hurt_box: HurtBox
var timer: float
var destroy_timer: float
var player: Player

const MAX_SPEED: float = 300.0
const ACELERATION: float = 75.0
const LOADING_TIME: float = 0.725 # time to load the attack
const LIFE_TIME: float = 5 # Time that the attack will live

func _ready() -> void:
	# Makes the fire ball start from the enemy mouth
	global_position = character.global_position + Vector2(40, -60)
	
	velocity = global_position.direction_to(
		player.global_position
	).normalized() * 150

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
	
	if velocity.length() <= MAX_SPEED:
		velocity += (velocity.normalized() + global_position.direction_to(player.global_position)) * ACELERATION * delta
	
	move_and_slide()

func shoot(_character: Character) -> void:
	hurt_box = $HurtBox
	hurt_box.area_entered.connect(on_area_entered)
	character = _character
	timer = LOADING_TIME
	destroy_timer = LIFE_TIME
	state = States.LOADING
	visible = false
	player = GlobalPlayerManager.player

func on_area_entered(area: Area2D):
	if area is HitBox:
		destroy()

func destroy():
	queue_free()
