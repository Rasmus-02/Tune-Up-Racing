extends Node2D
var loaded = false
var scene
@export var cars : Node
var main = null

func _ready():
	main = get_tree().get_root().get_node("Main")
	scene = main.new_scene

func _process(_delta):
	if loaded == false and SelectedScene.scene == "Track":
		var cars_loaded = 0
		for car in cars.get_children():
			if car.loaded == true:
				cars_loaded += 1
			
			if cars_loaded == cars.get_child_count():
				main.scene_changed()
				loaded = true
	
	#Unload if scene change detected
	elif scene != main.new_scene:
		for car in cars.get_children():
			car.delete_car()
