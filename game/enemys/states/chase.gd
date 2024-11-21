class_name EnemyStateChase extends State

@export var anim_name : String = "chase"
@export var chase_speed : float = 40.0
@export var turn_rate : float = 0.5

@export_category("AI")
@export var vision_area : VisionArea
@export var attack_area : HurtBox
@export var state_aggro_duration : float = 0.5
@export var next_state : State

var _timer : float = 0.0
var _direction : Vector2
var _can_see_player : bool = false

func init() -> void:
	if vision_area:
		vision_area.player_entered.connect( _on_player_enter )
		vision_area.player_exited.connect( _on_player_exit )

func enter() -> void:
	_timer = state_aggro_duration
	character.update_animation( anim_name )
	_can_see_player = true
	if attack_area:
		attack_area.monitoring = true

func exit() -> void:
	if attack_area:
		attack_area.monitoring = false
	_can_see_player = false

func process( _delta : float ) -> State:
	var new_dir : Vector2 = character.global_position.direction_to( GlobalPlayerManager.player.global_position )
	_direction = lerp( _direction, new_dir, turn_rate )
	character.velocity = _direction * chase_speed
	
	if character.set_direction( _direction ):
		character.update_animation( anim_name )
	
	if _can_see_player == false:
		_timer -= _delta
		if _timer < 0:
			return next_state
	else:
		_timer = state_aggro_duration
		
	return null

func _on_player_enter() -> void:
	_can_see_player = true
	#if(
			#state_machine.current_state is EnemyStateStun
			#or state_machine.current_state is EnemyStateDestroy
	#):
		#return
	state_machine.change_state( self )

func _on_player_exit() -> void:
	_can_see_player = false
