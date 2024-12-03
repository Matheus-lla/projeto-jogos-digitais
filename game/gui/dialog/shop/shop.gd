extends CanvasLayer

var player
var loaded = false

@onready var ui: Control = $UI
@onready var name_label: Label = $UI/Label
@onready var wepon: ShopItem
@onready var bow: ShopItem
@onready var heal: ShopItem
@onready var max_hp: ShopItem

func _ready() -> void:
	hide_shop()

func load_items():
	if loaded:
		return
	
	player = GlobalPlayerManager.player
	wepon = ShopItem.new(player.wepon, $UI/WeponPrice, $UI/Wepon, $UI/Sprite2D)
	bow = ShopItem.new(player.bow, $UI/BowPrice, $UI/Bow, $UI/Sprite2D2)
	max_hp = ShopItem.new(player.max_hp, $UI/MaxHpPrice, $UI/MaxHp, $UI/Sprite2D3)
	heal = ShopItem.new(player.heal, $UI/HealPrice, $UI/Heal, $UI/Sprite2D4)
	loaded = true
	
func update_ui():
	if not loaded:
		return
	
	wepon.update_ui()
	bow.update_ui()
	max_hp.update_ui()
	heal.update_ui()

func show_shop(character_name: String):
	ui.visible = true
	ui.process_mode = Node.PROCESS_MODE_ALWAYS
	name_label.text = character_name
	load_items()
	#get_tree().paused = true
	
func hide_shop():
	ui.visible = false
	ui.process_mode = Node.PROCESS_MODE_DISABLED
	#get_tree().paused = false
