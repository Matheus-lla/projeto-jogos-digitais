class_name Character extends CharacterBody2D

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var invulnerable: bool = false
var initial_hp: int
var initial_position: Vector2

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@export var hp: int

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var state_machine: StateMachine = $StateMachine

signal DirectionChanged(new_directions: Vector2)
signal CharacterDamaged(hurt_box: HurtBox)
signal CharacterDestroyed(hurt_box: HurtBox)

func _ready() -> void:
	initial_hp = hp
	initial_position = global_position
	GlobalPlayerManager.player_respawn.connect(on_respawn)

func on_respawn():
	global_position = initial_position
	hp = initial_hp

func _physics_process(_delta: float) -> void:
	move_and_slide()

func set_direction(_new_direction: Vector2) -> bool:
	direction = _new_direction
	
	if direction == Vector2.ZERO:
		return false
		
	var direction_index: int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_direction = DIR_4[direction_index]
	
	if new_direction == cardinal_direction:
		return false
		
	cardinal_direction = new_direction
	DirectionChanged.emit(new_direction)
	return true

func animation_direction() -> String:
	if cardinal_direction == Vector2.DOWN: return "down"
	elif cardinal_direction == Vector2.UP: return "up"
	elif cardinal_direction == Vector2.RIGHT: return "right"
	return "left"

func update_animation(state_str: String) -> void:
	animation.play(state_str + "_" + animation_direction())
	return
