extends Node

var kills = {}

func killed(victim_name: String):
	kills.get_or_add(victim_name, 0)
	kills[victim_name] += 1
