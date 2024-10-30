class_name Arrow extends Node2D

enum State {
	INACTIVE,
	THROW,
}

var player: Player
var direction: Vector2
var speed: float = 200.0
var state: State = State.INACTIVE

func _physics_process(delta: float) -> void:
	if state == State.INACTIVE:
		return
		
	position += speed * delta * direction
	print(position)
	
func shoot(dir: Vector2) -> void:
	player = GlobalPlayerManager.player
	global_position = player.global_position
	direction = dir
	state = State.THROW
