class_name EnemyStateChaseInfinity extends State

@export var anim_name : String = "chase"
@export var chase_speed : float = 40.0
@export var turn_rate : float = 0.5

@export_category("AI")
@export var vision_area : VisionArea
@export var attack_area : HurtBox

var _direction : Vector2

func enter() -> void:
	character.update_animation( anim_name )
	
	if vision_area:
		vision_area.monitoring = false
	
	if attack_area:
		attack_area.monitoring = true

func process( _delta : float ) -> State:
	var new_dir : Vector2 = character.global_position.direction_to( GlobalPlayerManager.player.global_position )
	_direction = lerp( _direction, new_dir, turn_rate )
	character.velocity = _direction * chase_speed
	
	if character.set_direction( _direction ):
		character.update_animation( anim_name )
		
	return null
