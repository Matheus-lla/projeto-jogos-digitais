class_name Arrow extends Node2D

enum State {
	INACTIVE,
	THROW,
}

var player: Player
var direction: Vector2
var speed: float = 200.0
var state: State

func _ready() -> void:
	visible = false
	state = State.INACTIVE
	player = GlobalPlayerManager.player

func _physics_process(delta: float) -> void:
	if state == State.INACTIVE:
		return
		
	position += speed * delta * direction
	
func throw(dir: Vector2) -> void:
	direction = dir
	state = State.THROW
	visible = true
