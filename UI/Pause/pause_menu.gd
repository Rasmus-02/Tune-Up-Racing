extends Control

@onready var pause_menu = $"."
@onready var sc_timer = $Scene_change_timer
@export var player : CharacterBody2D
var current_scene = ""
var main = null

func _ready():
	$MarginContainer/VBoxContainer/Restart.hide()
	main = get_tree().get_root().get_node("Main")
	Engine.time_scale = 1 #unpauses

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

func _process(_delta):
	scene_changed()
	if Input.is_action_just_pressed("Pause") and check_scene() != 0 and sc_timer.is_stopped():
		open_close_pause()
	elif pause_state == false and Input.is_action_just_pressed("ui_cancel"):
		open_close_pause()

var pause_state = true #menue starts closed
func open_close_pause():
	if player == null or player.ui_visible == false:
		if pause_state: #show menue
			$MarginContainer/VBoxContainer/Resume.grab_focus()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			Engine.time_scale = 0 #pauses
			pause_menu.show()
			#hide restart in garage
			if current_scene != "Track":
				$MarginContainer/VBoxContainer/Restart.hide()
			else:
				$MarginContainer/VBoxContainer/Restart.show()
			pause_state = false
		else: #hide menue
			if check_scene() == 1:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			Engine.time_scale = 1 #unpauses
			pause_menu.hide()
			pause_state = true

func _on_resume_pressed():
	open_close_pause()

func _on_quit_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if SelectedScene.scene == "garage": #Closes down the game
		get_tree().quit()
	else:
		RaceStatus.started = false
		Placing.car_list.clear()
		main.change_scene("garage")

func _on_restart_pressed():
	open_close_pause()
	main.change_scene("costal_circuit")
