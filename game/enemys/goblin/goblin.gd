class_name Goblin extends Character

var player : Player

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var hit_box : HitBox = $HitBox

func _ready():
	state_machine.init( self )
	player = GlobalPlayerManager.player
	hit_box.Damaged.connect(_take_damage)

func set_direction(_new_direction: Vector2) -> bool:
	var updated = super.set_direction(_new_direction)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return updated

func animation_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

func _take_damage( hurt_box : HurtBox ) -> void:
	if invulnerable == true:
		return
	hp -= hurt_box.damage
	if hp > 0:
		CharacterDamaged.emit( hurt_box )
	else:
		CharacterDestroyed.emit( hurt_box )
