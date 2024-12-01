class_name BurningAttack extends CharacterBody2D

enum States {
	INACTIVE, # No attack at all
	LOADING, # Charging attack before release
	GROWING,
	STABLE,
	SHRINKING,
}

var character: Character
var scale_factor: float
var state: States = States.INACTIVE
var hurt_box: HurtBox
var timer: float
var destroy_timer: float
var player: Player

const MAX_SPEED: float = 200.0
const ACELERATION: float = 80.0
const LOADING_TIME: float = 1.325 # time to load the attack
const LIFE_TIME: float = 6.5 # Time that the attack will live
const GROWING_TIME: float = 1
const STABLE_TIME: float = LIFE_TIME - GROWING_TIME - LOADING_TIME - 1
const FIRE_CENE =  preload("res://enemys/boitata/fire/fire.tscn")

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	# Makes the fire ball start from the enemy mouth
	global_position = character.global_position + Vector2(32, -170)

func _physics_process(delta: float) -> void:
	if state == States.INACTIVE:
		return
		
	destroy_timer -= delta
	
	if destroy_timer <= 0:
		destroy()
		
	timer -= delta
	
	if state == States.LOADING:
		if timer <= 0:
			state = States.GROWING
			timer = GROWING_TIME
			animation_player.play("growing")
			visible = true
			
		return
	
	move_and_slide()
	
	if state == States.GROWING:
		if timer <= 0:
			timer = STABLE_TIME
			state = States.STABLE
			scale_factor = 1	

		return
		
	if state == States.STABLE:
		velocity = global_position.direction_to(player.global_position) * 150
		
		if timer <= 0:
			animation_player.play("shrinking")
			velocity = Vector2.ZERO
			state = States.SHRINKING
			scale_factor = 0.999
			await get_tree().create_timer(0.9).timeout
			hurt_box.monitoring = true
			
			for i in randi_range(1, 5):
				var fire = FIRE_CENE.instantiate() as Fire
				fire.start(
					global_position + Vector2(randf_range(-20.0, 20.0), randf_range(-20.0, 20.0)),
					randf_range(2.0, 8.0)
				)
				add_sibling(fire)

func shoot(_character: Character) -> void:
	character = _character
	hurt_box = $HurtBox
	hurt_box.area_entered.connect(on_area_entered)
	timer = LOADING_TIME
	destroy_timer = LIFE_TIME
	state = States.LOADING
	visible = false
	hurt_box.monitoring = false
	player = GlobalPlayerManager.player

func on_area_entered(area: Area2D):
	if area is HitBox:
		destroy()

func destroy():
	queue_free()
