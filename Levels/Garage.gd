extends Node2D

var scene = "car"
var loaded = false
@export var cars : Node2D
var main = null

func _ready():
	SelectedScene.scene = SelectedScene.garage[0]
	main = get_tree().get_root().get_node("Main")
	main.scene_changed()



func _on_gate_body_entered(body):
	if body.is_in_group("Player"):
		SelectedScene.scene = "changing"
		get_parent().change_scene("parking_garage")
