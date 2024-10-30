class_name Arrow extends CharacterBody2D

enum State {
	INACTIVE,
	FLIGHT,
}

var player: Player
var state: State = State.INACTIVE
var hurt_box: HurtBox

func _physics_process(_delta: float) -> void:
	if state == State.INACTIVE:
		return

	move_and_slide()
	
	if is_on_wall():
		destroy()

func shoot() -> void:
	hurt_box = $HurtBox
	hurt_box.area_entered.connect(on_area_entered)
	player = GlobalPlayerManager.player
	global_position = player.global_position
	self.velocity = player.faced_direction() * 200.0
	state = State.FLIGHT

func on_area_entered(area: Area2D):
	if area is HitBox:
		destroy()

func destroy():
	queue_free()
