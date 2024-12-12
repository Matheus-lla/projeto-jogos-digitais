class_name Snake extends Character

var player : Player

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var hit_box : HitBox = $Rotation/HitBox
@onready var sprite: Sprite2D = $Sprite2D
@onready var hurt_box: HurtBox = $Rotation/HurtBox
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready():
	super._ready()
	state_machine.init( self )
	player = GlobalPlayerManager.player
	hit_box.Damaged.connect(_take_damage)

func _take_damage( _hurt_box : HurtBox ) -> void:
	if invulnerable == true:
		return
	hp -= _hurt_box.damage
	if hp > 0:
		CharacterDamaged.emit( _hurt_box )
	else:
		CharacterDestroyed.emit( _hurt_box )
