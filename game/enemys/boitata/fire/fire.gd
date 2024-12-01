class_name Fire extends Node2D

enum States {
	NULL,
	START,
	BURN,
	END
}

var state: States = States.NULL
var timer: float
var animation_player: AnimationPlayer
var hurt_box: HurtBox
var start_position: Vector2
var burn_time: float

const START_TIME = 1.0
const END_TIME = 1.0

func _ready() -> void:
	if state == States.NULL:
		start(global_position, 12.0)
		
	global_position = start_position
	
func _physics_process(delta: float) -> void:
	timer -= delta
	
	if state == States.START:
		if timer <= 0:
			state = States.BURN
			timer = burn_time
			hurt_box.monitoring = true
			update_animation("loop")
			
	if state == States.BURN:
		if timer <= 0:
			state = States.END
			timer = END_TIME
			hurt_box.monitoring = false
			update_animation("end")
			
	if state == States.END:
		if timer <= 0:
			queue_free()
			
func update_animation(animation_name: String):
	animation_player.play("RESET")
	animation_player.play(animation_name)
	

func start(_position: Vector2, _burn_time) -> void:
	burn_time = _burn_time
	start_position = _position
	animation_player  = $AnimationPlayer
	hurt_box = $HurtBox
	timer = START_TIME
	state = States.START
	update_animation("start")
	hurt_box.monitoring = false
