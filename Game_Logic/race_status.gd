extends Node

var started = false
var finished = false

var player_position : int
var reward_bonus : float

func _ready():
	#Set script to "not pauseable"
	process_mode = Node.PROCESS_MODE_ALWAYS
