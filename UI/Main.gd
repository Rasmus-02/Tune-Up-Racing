extends Node2D
var garage = preload("res://Levels/Garage.tscn")
var parking_garage = preload("res://Levels/Parking Garage.tscn")
var costal_circuit = preload("res://Levels/Costal_Circuit_Scene.tscn")
var splash_screen = preload("res://UI/Loading/splash_screen.tscn")
@export var pause_menu : CanvasLayer
@export var load_screen : Node2D
@export var sell_menu : CanvasLayer
var current_scene_instance = null
var current_scene
var pause_blocked = false

func _ready():
	load_new_scene(splash_screen)

func _input(_event):
	if Input.is_action_just_pressed("Pause") and pause_blocked == false: #Open or close pause menu
		open_close_pause_menu()

func open_close_pause_menu():
	if pause_menu.visible:
		pause_menu.close()
	else:
		update_pause_menu_position()
		pause_menu.open()
	pass


func update_pause_menu_position():
	if SelectedScene.scene == "Track":
		pause_menu.get_child(0).global_position = get_child(3).get_node("Track").global_position


var new_scene
func change_scene(scene):
	#Update Car market
	CarMarket.update_events()
	
	AudioServer.set_bus_volume_db(1, linear_to_db(Settings.car_volume))
	AudioServer.set_bus_volume_db(2, linear_to_db(Settings.ambient_volume))
	new_scene = scene
	RaceStatus.started = false
	RaceStatus.finished = false
	Placing.car_list.clear()
	Placing.placing_list.clear()
	Placing.player_lap = 0
	load_screen.change_scene(scene)


#This gets called after change scene animation is done
func load_new_scene(scene):
	if scene is String:
		match scene:
			"costal_circuit":
				scene = costal_circuit
				Engine.max_fps = 200
				Sound.music.stop()
				Sound.music.play()
			"garage":
				scene = garage
				Engine.max_fps = 100
				Sound.music.stop()
			"parking_garage":
				scene = parking_garage
				Engine.max_fps = 100
	Utils.free_orphaned_nodes()
	var scene_instance = scene.instantiate()
	add_child(scene_instance) #add scene
	
	if current_scene_instance != null:
		current_scene_instance.free()
		current_scene_instance = null
	current_scene_instance = scene_instance #Set new scene as current scene
	current_scene = scene


#Gets called from scene afdter everything in scene is loaded
func scene_changed():
	load_screen.scene_changed()
