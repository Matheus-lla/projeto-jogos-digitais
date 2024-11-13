extends CanvasLayer

var player

@onready var ui: Control = $UI
@onready var name_label: Label = $UI/Label
@onready var wepon: Button = $UI/Wepon
@onready var bow: Button = $UI/Bow
@onready var heal: Button = $UI/Heal
@onready var max_hp: Button = $UI/MaxHp
@onready var wepon_price: Label = $UI/WeponPrice
@onready var bow_price: Label = $UI/BowPrice
@onready var max_hp_price: Label = $UI/MaxHpPrice
@onready var heal_price: Label = $UI/HealPrice

func _ready() -> void:
	hide_shop()
	wepon.pressed.connect(on_wepon_pressed)
	bow.pressed.connect(on_bow_pressed)
	heal.pressed.connect(on_heal_pressed)
	max_hp.pressed.connect(on_max_hp_pressed)

func on_player_ready():
	if !player and GlobalPlayerManager.player: 
		player = GlobalPlayerManager.player
	
func show_shop(character_name: String):
	ui.visible = true
	ui.process_mode = Node.PROCESS_MODE_ALWAYS
	name_label.text = character_name
	on_player_ready()
	update_ui()
	#get_tree().paused = true
	
func update_ui():
	wepon_ui()
	bow_enabled()
	max_hp_enabled()
	heal_enabled()
	
func hide_shop():
	ui.visible = false
	ui.process_mode = Node.PROCESS_MODE_DISABLED
	#get_tree().paused = false

func wepon_ui():
	if player.current_wepon_level >= player.max_level or player.wepon_upgrade_cost() > PlayerHud.guarana:
		wepon.disabled = true
		wepon_price.text = ""
		return
		
	wepon.disabled = false
	wepon_price.text = "R$ " + str(player.wepon_upgrade_cost())
	
	
func bow_enabled():
	if player.current_bow_level >= player.max_level or player.bow_upgrade_cost() > PlayerHud.guarana:
		bow.disabled = true
		bow_price.text = ""
		return
		
	bow.disabled = false
	bow_price.text = "R$ " + str(player.bow_upgrade_cost())
	
func heal_enabled():
	if player.current_heal_level >= player.max_level or player.heal_upgrade_cost() > PlayerHud.guarana:
		heal.disabled = true
		heal_price.text = ""
		return
		
	heal.disabled = false
	heal_price.text = "R$ " + str(player.heal_upgrade_cost())
	
func max_hp_enabled():
	if player.current_max_hp_level >= player.max_level or player.max_hp_upgrade_cost() >= PlayerHud.guarana:
		max_hp.disabled = true
		max_hp_price.text = ""
		return
		
	max_hp.disabled = false
	max_hp_price.text = "R$ " + str(player.max_hp_upgrade_cost())

func on_wepon_pressed():
	player.wepon_upgrade()
	update_ui()
	
func on_bow_pressed():
	player.bow_upgrade()
	update_ui()
	
func on_max_hp_pressed():
	player.max_hp_upgrade()
	update_ui()
	
func on_heal_pressed():
	player.heal_upgrade()
	update_ui()
