class_name Seller extends Character

var player: Player

@onready var dialog: Node = $StateMachine/Dialog
@onready var idle: NPCIdle = $StateMachine/Idle
@onready var area_2d: Sell = $Sell

func _ready() -> void:
	state_machine.init(self)
	player = GlobalPlayerManager.player
	area_2d.area_entered.connect(on_dialog_enter)
	area_2d.area_exited.connect(on_dialog_exit)

func on_dialog_enter(_area: Area2D):
	state_machine.change_state(dialog)	

func on_dialog_exit(_area: Area2D):
	state_machine.change_state(idle)	
