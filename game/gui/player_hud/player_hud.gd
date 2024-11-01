extends CanvasLayer

var hearts: Array[Heart] = []
var potions: Array[HealthPotion] = []

func _ready() -> void:
	for child in $Control/HFlowContainer.get_children():
		if child is Heart:
			child.visible = false
			hearts.append(child)
			
	for child in $Control/HFlowContainer2.get_children():
		if child is HealthPotion:
			potions.append(child)
		
	

func update_heart(index: int, hp: int):
	var value: int = clampi(hp - index * 2, 0, 2)
	hearts[index].value = value
	

func update_potion(index: int, potion: int):
	var value: int = clampi(potion - index * 2, 0, 2)
	potions[index].value = value

func update_max_hp(max_hp: int):
	var heart_count: int = roundi(max_hp / 2)
	
	for i in hearts.size():
		if i < heart_count:
			hearts[i].visible = true
		else:
			hearts[i].visible = false

func update_hp(hp: int, max_hp: int):
	update_max_hp(max_hp)
	
	for i in max_hp:
		update_heart(i, hp)
		
func update_potion_after_use(potion: int):
	for i in 3:
		update_potion(i, potion)
	
	
