class_name Villager extends Character

var player: Player

@onready var sprite: Sprite2D = $Sprites/Sprite2D
@onready var dialog: Node = $StateMachine/Dialog
@onready var idle: VillagerIdle = $StateMachine/Idle
@onready var dialog_sequence: DialogSequence = $DialogSequence

func _ready() -> void:
	state_machine.init(self)
	player = GlobalPlayerManager.player
	dialog_sequence.area_entered.connect(on_dialog_enter)
	dialog_sequence.area_exited.connect(on_dialog_exit)

func on_dialog_enter(_area: Area2D):
	if dialog_sequence.get_next_dialog():
		state_machine.change_state(dialog)	

func on_dialog_exit(_area: Area2D):
	state_machine.change_state(idle)	
