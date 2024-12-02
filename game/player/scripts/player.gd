class_name Player extends Character

var max_level = 3

var current_wepon_level = 0
var wepon_level_cost = [20, 40, 80]
var wepon_damage_by_level = [4, 6, 8]

var current_bow_level = 0
var bow_level_cost = [15, 30, 60]
var bow_damage_by_level = [2, 3, 4]
var bow_damage = 1

var current_max_hp_level = 0
var max_hp_level_cost = [10, 30, 100]
var max_hp_by_level = [4, 6, 8]

var current_heal_level = 0
var heal_level_cost = [10, 25, 50]
var heal_by_level = [3, 4, 5]

var max_hp: int = 2
var kills: int = 0

@export var spawn_place: Spawn

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var effect_animation_player: AnimationPlayer = $EffectAnimationPlayer
@onready var sprite: Sprite2D = $PlayerSprite
@onready var hit_box: HitBox = $HitBox
@onready var idle: Idle = $StateMachine/Idle
@onready var melee_hurt_box: HurtBox = $MeleeHurtBox
@onready var camera: Camera = $Camera

func _ready() -> void:
	GlobalPlayerManager.player = self
	state_machine.init(self)
	hit_box.Damaged.connect(on_damaged)
	spawn()
	PlayerHud.update_guarana(100)


func _process(_delta: float) -> void:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down"),
	).normalized()
	
func set_direction(_new_direction: Vector2 = Vector2.ZERO) -> bool:
	if direction == Vector2.ZERO:
		return false
		
	return super.set_direction(direction)
	
func update_animation(state_str: String) -> void:
	animation_player.play(state_str + "_" + animation_direction())
	return
	
func update_hp(delta: int):
	hp = clampi(hp + delta, 0, max_hp)
	PlayerHud.update_hp(hp, max_hp)
	
func make_invulnerable(duration: float):
	if duration <= 0:
		return
	
	invulnerable = true
	hit_box.monitoring = false
	await get_tree().create_timer(duration).timeout
	invulnerable = false
	hit_box.monitoring = true
	
func on_damaged(hurt_box: HurtBox):
	if invulnerable:
		return
		
	update_hp(-hurt_box.damage)
	
	if hp <= 0:
		self.spawn()
		return	
	
	CharacterDamaged.emit(hurt_box)

func spawn():
	update_hp(max_hp)
	PlayerHud.update_potion(PlayerHud.max_potion)
	PlayerHud.update_guarana(-PlayerHud.guarana)
	
	for c in get_parent().get_children(false):
		if c is Guarana:
			c.guarana_spawm()
	
	
	if spawn_place:
		self.global_position = spawn_place.global_position
		
	direction = Vector2.DOWN
	cardinal_direction	= Vector2.DOWN		
	set_direction()
	animation_player.play("idle_down")
	state_machine.change_state(idle)
	
func faced_direction() -> Vector2:
	var dir = direction
	
	if dir == Vector2.ZERO:
		dir = cardinal_direction
		
	return dir

func wepon_upgrade_cost():
	return wepon_level_cost[current_wepon_level]

func wepon_upgrade():
	PlayerHud.update_guarana(-wepon_upgrade_cost())
	melee_hurt_box.damage = wepon_damage_by_level[current_wepon_level]
	current_wepon_level += 1
	
func bow_upgrade_cost():
	return bow_level_cost[current_bow_level]

func bow_upgrade():
	PlayerHud.update_guarana(-bow_upgrade_cost())
	bow_damage = bow_damage_by_level[current_bow_level]
	current_bow_level += 1
	
func max_hp_upgrade_cost():
	return max_hp_level_cost[current_max_hp_level]

func max_hp_upgrade():
	PlayerHud.update_guarana(-max_hp_upgrade_cost())
	max_hp = max_hp_by_level[current_max_hp_level]
	update_hp(max_hp)
	current_max_hp_level += 1
	
func heal_upgrade_cost():
	return heal_level_cost[current_heal_level]

func heal_upgrade():
	PlayerHud.update_guarana(-heal_upgrade_cost())
	PlayerHud.max_potion = heal_by_level[current_heal_level]
	PlayerHud.update_potion(PlayerHud.max_potion)
	current_heal_level += 1
