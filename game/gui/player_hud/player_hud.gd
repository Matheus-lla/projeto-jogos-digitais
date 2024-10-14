extends CanvasLayer

var hearts: Array[Heart] = []

func _ready() -> void:
	for child in $Control/HFlowContainer.get_children():
		if child is Heart:
			child.visible = false
			hearts.append(child)

func update_heart(index: int, hp: int):
	var value: int = clampi(hp - index * 2, 0, 2)
	hearts[index].value = value
	
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
	
