extends CanvasLayer

@onready var pause_menu = $"."
@onready var sc_timer = $Control/Scene_change_timer
@export var restart : TextureButton
@export var resume : TextureButton
@export var player : CharacterBody2D
@export var settings : Sprite2D
@export var menu : Sprite2D
var current_scene = ""
var main = null

func _ready():
	restart.hide()
	main = get_tree().get_root().get_node("Main")
	get_tree().paused = false #unpauses

func open():
	AudioServer.set_bus_volume_db(1, -80)
	AudioServer.set_bus_volume_db(2, -80)
	#hide restart in garage
	if SelectedScene.scene != "Track":
		restart.hide()
	else:
		restart.show()
	get_tree().paused = true #pauses
	pause_menu.show()

func close():
	AudioServer.set_bus_volume_db(1, linear_to_db(Settings.car_volume))
	AudioServer.set_bus_volume_db(2, linear_to_db(Settings.ambient_volume))
	get_tree().paused = false #unpauses
	pause_menu.hide()

func check_scene():
	if SelectedScene.scene == "Track": #hide cursor
		player = null
		return 1
	elif SelectedScene.scene == "garage": #show cursor
		return 2
	else:
		return 0

func scene_changed():
	if current_scene != SelectedScene.scene:
		sc_timer.start()
		if check_scene() == 1:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else: 
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		current_scene = SelectedScene.scene


# = Buttons =======================================================================
func _on_resume_pressed():
	close()

func _on_quit_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if SelectedScene.scene == "garage": #Closes down the game
		Save_Load.save()
		get_tree().quit() #WEBBUILD
	else:
		Placing.car_list.clear()
		main.change_scene("garage")
		close()



func _on_restart_pressed():
	close()
	Placing.car_list.clear()
	main.change_scene(main.current_scene_name)

var settings_open = false
func _on_settings_pressed():
	settings.open()
	settings_open = true
	
