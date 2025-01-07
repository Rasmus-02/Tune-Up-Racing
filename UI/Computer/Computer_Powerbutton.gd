extends Node2D

@export var player : Node2D
var main = null

func _ready():
	main = get_tree().get_root().get_node("Main")


func _on_button_pressed():
	main.pause_blocked = false
	##Press back button twice to 100% make sure returns to main page
	$Webbrowser.get_node("Page Selector")._on_back_button_pressed()
	$Webbrowser.get_node("Page Selector")._on_back_button_pressed()
	player.stop_interacting()
	$AudioStreamPlayer2D.stop()

func start_computer():
	main.pause_blocked = true
	$AudioStreamPlayer2D.play()
