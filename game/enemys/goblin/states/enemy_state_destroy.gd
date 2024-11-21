class_name EnemyStateDestroy extends State


@export var anim_name : String = "destroy"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")

@export_category("Item Drops")

var _damage_position : Vector2
var _direction : Vector2

func init() -> void:
	character.enemy_destroyed.connect( _on_enemy_destroyed )
	pass

func enter() -> void:
	character.invulnerable = true
	_direction = character.global_position.direction_to( _damage_position )
	character.set_direction( _direction )
	character.velocity = _direction * -knockback_speed
	character.update_animation( anim_name )
	character.animation_player.animation_finished.connect( _on_animation_finished )
	disable_hurt_box()
	pass

func process( _delta : float ) -> State:
	character.velocity -= character.velocity * decelerate_speed * _delta
	return null

func _on_enemy_destroyed( hurt_box : HurtBox ) -> void:
	_damage_position = hurt_box.global_position
	state_machine.change_state( self )

func _on_animation_finished( _a : String ) -> void:
	character.queue_free()

func disable_hurt_box() -> void:
	var hurt_box : HurtBox = character.get_node_or_null("HurtBox")
	if hurt_box:
		hurt_box.monitoring = false
