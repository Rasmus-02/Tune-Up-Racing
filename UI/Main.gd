extends Node2D
var garage = load("res://Levels/Garage.tscn")
var costal_circuit = load("res://Levels/Costal_Circuit_Scene.tscn")
@export var pause_menu : CanvasLayer
var current_scene_instance = null
var current_scene

func _ready():
	change_scene(garage)

func _input(event):
	if Input.is_action_just_pressed("Pause"): #Open or close pause menu
		open_close_pause_menu()

func open_close_pause_menu():
	if pause_menu.visible:
		pause_menu.hide()
	else:
		update_pause_menu_position()
		pause_menu.show()
	pass

func update_pause_menu_position():
	if SelectedScene.scene == "garage":
		pause_menu.get_child(0).global_position = get_node("Garage").get_node("Player").global_position





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
