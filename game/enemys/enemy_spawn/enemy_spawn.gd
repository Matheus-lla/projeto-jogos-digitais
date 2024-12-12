class_name EnemySpawn extends Node2D


@export var enemys: Array[PackedScene]
@export var probabilites: Array[float]
@export var spawn_cooldown: float = 1.0
@export var spawn_radius: float = 50.0
@export var start_when_ready: bool
@export var parent: Node

var active = false
var timer: float

func _ready() -> void:
	assert(enemys.size() == probabilites.size())
	
	for enemy in enemys:
		assert(enemy != null)
		
	var sum: float = 0.0
	
	for probabilite in probabilites:
		sum += probabilite
		
	assert(sum == 1.0)
	
	if start_when_ready:
		start()

func stop():
	timer = spawn_cooldown
	active = false

func start():
	timer = spawn_cooldown
	active = true
	
func choice():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var rnd = rng.randf()

	var i = 0
	var sum:float = 0.0

	for val in probabilites:
		sum += val
		if sum >= rnd:
			return enemys[i]
		i += 1

func spawn_enemy():
	var enemy = choice().instantiate() as Character
	parent.add_child(enemy)
	var random_postition = Vector2(randf_range(-spawn_radius, spawn_radius), randf_range(-spawn_radius, spawn_radius))
	enemy.global_position = global_position + random_postition
	
func _process(delta: float) -> void:
	if !active:
		return
		
	timer -= delta
	
	if timer <= 0:
		timer = spawn_cooldown
		spawn_enemy()
