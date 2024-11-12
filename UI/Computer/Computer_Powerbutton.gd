extends Node2D

@export var player : Node2D


func _on_button_pressed():
	$Webbrowser.get_node("Page Selector")._on_back_button_pressed()
	player.stop_interacting()
	$AudioStreamPlayer2D.stop()

func start_computer():
	$AudioStreamPlayer2D.play()
