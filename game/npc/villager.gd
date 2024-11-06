class_name Villager extends CharacterBody2D

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var invulnerable: bool = false
var player: Player
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@onready var sprite: Sprite2D = $Sprites/Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var state_machine: VillagerStateMachine = $StateMachine
@onready var dialog: Node = $StateMachine/Dialog
@onready var idle: VillagerStateIdle = $StateMachine/Idle
@onready var dialog_sequence: Area2D = $DialogSequence

signal DirectionChanged(new_directions: Vector2)

func _ready() -> void:
	state_machine.init(self)
	player = GlobalPlayerManager.player
	dialog_sequence.area_entered.connect(on_dialog_enter)
	dialog_sequence.area_exited.connect(on_dialog_exit)

func _process(_delta: float) -> void:
	pass
	
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
	#sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true
	
func update_animation(state_str: String) -> void:
	animation.play(state_str + "_" + animation_direction())
	return
	
func animation_direction() -> String:
	if cardinal_direction == Vector2.DOWN: return "down"
	elif cardinal_direction == Vector2.UP: return "up"
	elif cardinal_direction == Vector2.RIGHT: return "right"
	return "left"
	
func on_dialog_enter(_area: Area2D):
	state_machine.change_state(dialog)	

func on_dialog_exit(_area: Area2D):
	state_machine.change_state(idle)	
