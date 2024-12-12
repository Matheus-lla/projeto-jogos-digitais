class_name Snake extends Character

var player : Player

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var hit_box : HitBox = $HitBox
@onready var sprite: Sprite2D = $Node2D/Sprite2D

func _ready():
	state_machine.init( self )
	player = GlobalPlayerManager.player
	hit_box.Damaged.connect(_take_damage)
	animation_player.play("walking_left")

# Overrides default implementation
func animation_direction() -> String:
	return "left"

func set_direction(_new_direction: Vector2) -> bool:
	var updated = super.set_direction(_new_direction)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return updated

func _take_damage( hurt_box : HurtBox ) -> void:
	if invulnerable == true:
		return
	hp -= hurt_box.damage
	if hp > 0:
		CharacterDamaged.emit( hurt_box )
	else:
		CharacterDestroyed.emit( hurt_box )
