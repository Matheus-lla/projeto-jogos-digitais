class_name Upgradable extends Node

signal Upgraded()

var item_name: String
var current_level: int
var current_value: int
var level_costs: Array[int]
var level_values: Array[int]

func _init(
	_item_name: String,
	_level_costs: Array[int],
	_level_values: Array[int],
):
	item_name = _item_name
	current_level = 0
	level_costs = _level_costs
	level_values = _level_values
	Upgraded.emit(self)
	
func get_value():
	return level_values[current_level]
	
func upgrade_cost():
	return level_costs[current_level]

func upgrade():
	var cost = upgrade_cost()
	current_level += 1
	PlayerHud.update_guarana(-cost)
	Upgraded.emit()
	
func max() -> bool:
	if current_level == level_costs.size():
		return true
	
	return false
