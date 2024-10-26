extends Node

var common = Color(0.84,0.84,0.84,1)
var uncommon = Color(0.39,0.82,0.24,1)
var rare = Color(0.125,0.42,0.86,1)
var epic = Color(0.86,0.164,0.84,1)
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
