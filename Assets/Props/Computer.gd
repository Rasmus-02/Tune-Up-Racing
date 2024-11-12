extends Node2D

@export var player : Node2D

func open_computer():
	player.get_child(0).get_node("Computer").show()
	player.get_child(0).get_node("Computer").start_computer()

func close_computer():
	player.get_child(0).get_node("Computer").hide()

func interact():
	open_computer()
	
func exit():
	close_computer()
