extends Node2D

var scene = "car"
var loaded = false
@export var cars : Node2D
var main = null

func _ready():
	SelectedScene.scene = SelectedScene.garage[0]
	main = get_tree().get_root().get_node("Main")
	main.scene_changed()


func drive():
	get_parent().change_scene("costal_circuit")
	#SelectedScene.next_scene = "res://Levels/Costal_Circuit_Scene.tscn"
	#get_tree().change_scene_to_file("res://Levels/loading.tscn")
