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
	if player.current_wepon_level >= player.max_level:
		wepon_price.text = ""
		wepon.disabled = true
		return
		
	if player.wepon_upgrade_cost() > PlayerHud.guarana:
		wepon_price.text = "R$ " + str(player.wepon_upgrade_cost())
		wepon.disabled = true
		return
		
	wepon.disabled = false
	wepon_price.text = "R$ " + str(player.wepon_upgrade_cost())
	
	
func bow_enabled():
	if player.current_bow_level >= player.max_level:
		bow_price.text = ""
		bow.disabled = true
		return
		
	if player.bow_upgrade_cost() > PlayerHud.guarana:
		bow_price.text = "R$ " + str(player.bow_upgrade_cost())
		bow.disabled = true
		return
		
	bow.disabled = false
	bow_price.text = "R$ " + str(player.bow_upgrade_cost())
	
func heal_enabled():
	if player.current_heal_level >= player.max_level:
		heal_price.text = ""
		heal.disabled = true
		return
		
	if player.heal_upgrade_cost() > PlayerHud.guarana:
		heal_price.text = "R$ " + str(player.heal_upgrade_cost())
		heal.disabled = true
		return
		
	heal.disabled = false
	heal_price.text = "R$ " + str(player.heal_upgrade_cost())
	
func max_hp_enabled():
	if player.current_max_hp_level >= player.max_level:
		max_hp_price.text = ""
		max_hp.disabled = true
		return
		
	if player.max_hp_upgrade_cost() > PlayerHud.guarana:
		max_hp_price.text = "R$ " + str(player.max_hp_upgrade_cost())
		max_hp.disabled = true
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
