extends Node2D
var garage = load("res://Levels/Garage.tscn")
var costal_circuit = load("res://Levels/Costal_Circuit_Scene.tscn")
var current_scene_instance = null
var current_scene

func _ready():
	change_scene(garage)

func change_scene(scene):
	if scene is String:
		match scene:
			"costal_circuit":
				scene = costal_circuit
			"garage":
				scene = garage
	var scene_instance = scene.instantiate()
	add_child(scene_instance) #add scene
	
	if current_scene_instance != null:
		current_scene_instance.queue_free() #Remove old scene
	current_scene_instance = scene_instance #Set new scene as current scene
	current_scene = scene
