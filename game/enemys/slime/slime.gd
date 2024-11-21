class_name Slime extends Character

var player: Player

@onready var sprite: Sprite2D = $Body
@onready var hit_box: HitBox = $HitBox
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	state_machine.init(self)
	player = GlobalPlayerManager.player
	hit_box.Damaged.connect(on_damaged)

func on_damaged(hurt_box: HurtBox):
	if invulnerable:
		return
	
	hp -= hurt_box.damage
	
	if hp <= 0:
		CharacterDestroyed.emit(hurt_box)
		return
	
	CharacterDamaged.emit(hurt_box)

func set_direction(_new_direction: Vector2) -> bool:
	var updated = super.set_direction(_new_direction)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return updated

func animation_direction() -> String:
	if cardinal_direction == Vector2.DOWN: return "down"
	elif cardinal_direction == Vector2.UP: return "up"
	return "side"
