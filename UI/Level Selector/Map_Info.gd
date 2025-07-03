extends TextureRect

# Minimaps
var costal_circuit_minimap = preload("res://Textures/UI/Minimaps/Costal Circuit Minimap.png")
var town_track_minimap = preload("res://Textures/UI/Minimaps/Town Track Minimap.png")

enum {OPPONENT, TIMEATTACK, DRIFT, BUILDCHALLENGE}
@export var main : Node2D
@onready var map_name_label = $"Labels/Map Name"
@onready var worldmap = $".."
@onready var minimap = $Labels/TextureRect
@onready var bottom_info = $"Labels/Bottom Info"
var selected_map : String


func _input(_event):
	if Input.is_action_just_pressed("Pause"):
		close()
	if Input.is_action_just_released("Pause"):
		await get_tree().process_frame
		worldmap.exit_blocked = false



func open(map_name):
	main.gamemode = OPPONENT
	
	# Select correct map (for main function when "play" is pressed)
	selected_map = map_name
	# Block closing of worldmap
	worldmap.exit_blocked = true
	
	## Change info about map
	# Change the name
	map_name_label.text = format_string(map_name)
	# Change the minimap
	match map_name:
		"costal_circuit":
			set_map_layout(costal_circuit_minimap)
		"town_track":
			set_map_layout(town_track_minimap)
	# Change the bottom info
	update_bottom_info()
	
	# Open the map info card
	show()

func close():
	hide()


func update_bottom_info():
	var info_1 = bottom_info.get_node("Left").get_child(0)
	var info_2 = bottom_info.get_node("Left").get_child(1)
	var info_3 = bottom_info.get_node("Right").get_child(0)
	match main.gamemode:
		OPPONENT:
			info_1.text = "Mode: Race vs AI"
			info_2.text = "Race against AI cars \nand try to win"
		TIMEATTACK:
			info_1.text = "Mode: Time Attack"
			info_2.text = "Race vs the clock"
		DRIFT:
			info_1.text = "Mode: Drift"
			info_2.text = "Drift to gain points"
		BUILDCHALLENGE:
			info_1.text = "Mode: Build Challenge"
			info_2.text = "Rules: <300nm torque, \n>1500kg"

func set_map_layout(map):
	minimap.texture = map

# Format the string so that "_" becomes " " and first letter after spacing is capital
func format_string(input: String) -> String:
	return input.replace("_", " ").capitalize()

# Start the race
func _on_play_button_pressed():
	worldmap.main.change_scene(selected_map)
	
	# Close every tab
	close()
	worldmap.exit_blocked = false
	worldmap.close()
	worldmap.main.pause_blocked = false


func _on_ai_race_button_pressed():
	main.gamemode = OPPONENT
	update_bottom_info()
func _on_timeattack_button_pressed():
	main.gamemode = TIMEATTACK
	update_bottom_info()
func _on_drift_button_pressed():
	main.gamemode = DRIFT
	update_bottom_info()
func _on_car_build_button_pressed():
	main.gamemode = BUILDCHALLENGE
	update_bottom_info()
