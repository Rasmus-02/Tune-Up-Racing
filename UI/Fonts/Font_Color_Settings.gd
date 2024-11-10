extends Node

var common = Color(0.84,0.84,0.84)
var uncommon = Color(0.374, 0.782, 0.232)
var rare = Color(0.125,0.42,0.86)
var epic = Color(0.762, 0.0018, 0.92)
var legendary = Color(1,0.64,0.1,1)

func get_color(string):
	match string:
		"common":
			return common
		"uncommon":
			return uncommon
		"rare":
			return rare
		"epic":
			return epic
		"legendary":
			return legendary
