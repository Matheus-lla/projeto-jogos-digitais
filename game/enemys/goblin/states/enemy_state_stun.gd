class_name EnemyStateStun extends State


@export var anim_name : String = "stun"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")
@export var next_state : State

var _damage_position : Vector2
var _direction : Vector2
var _animation_finished : bool = false

func init() -> void:
	character.enemy_damaged.connect( _on_enemy_damaged )

func enter() -> void:
	character.invulnerable = true
	_animation_finished = false
	
	_direction = character.global_position.direction_to( _damage_position )
	
	character.set_direction( _direction )
	character.velocity = _direction * -knockback_speed
	
	character.update_animation( anim_name )
	character.animation_player.animation_finished.connect( _on_animation_finished )

func exit() -> void:
	character.invulnerable = false
	character.animation_player.animation_finished.disconnect( _on_animation_finished )

func process( _delta : float ) -> State:
	if _animation_finished == true:
		return next_state
	character.velocity -= character.velocity * decelerate_speed * _delta
	return null

func _on_enemy_damaged( hurt_box : HurtBox ) -> void:
	_damage_position = hurt_box.global_position
	state_machine.change_state( self )

func _on_animation_finished( _a : String ) -> void:
	_animation_finished = true
