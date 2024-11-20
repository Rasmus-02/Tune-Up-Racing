extends Node

var file_location = "user://settings.save"
var resolution_settings = {0 : Vector2(1280, 720), 1 : Vector2(1920, 1080), 2 : Vector2(2560, 1440)}


#General
var camera_mode : int #0 = static || 1 = dynamic
var display_mode : int #0 = fullscreen || 1 = windowed borderless || 2 = windowed
var resolution = 0 #the index in resolution settings
var vsync : int #0 = off || 1 = on

#Audio
var general_volume : float #0 - 1
var car_volume : float #0 - 1
var music_volume : float #0 - 1
var ambient_volume : float #0 - 1

func _ready():
	#If file doesn't exist create new file
	if FileAccess.file_exists(file_location) == false:
		print("NEW SETTINGS FILE CREATED")
		var file = FileAccess.open(file_location, FileAccess.WRITE)
		save_settings()
	
	#Load the file
	load_file()

func save_settings():
	if FileAccess.file_exists(file_location):
		var save_dict = {"camera_mode" : camera_mode, "display_mode" : display_mode, "resolution" : resolution,
		"vsync" : vsync, "general_volume" : general_volume, "car_volume" : car_volume, "music_volume" : music_volume,
		"ambient_volume" : ambient_volume}
		var save_game = FileAccess.open(file_location, FileAccess.WRITE)
		var json_string = JSON.stringify(save_dict)
		save_game.store_line(json_string)
	else:
		"ERROR: NULL SETTINGS FILE LOCATION"

func load_file():
	if FileAccess.file_exists(file_location):
		var dataFile = FileAccess.open(file_location, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		
		#General
		camera_mode = parsedResult.camera_mode
		display_mode = parsedResult.display_mode
		resolution = parsedResult.resolution
		vsync = parsedResult.vsync
		#Audio
		general_volume = parsedResult.general_volume
		car_volume = parsedResult.car_volume
		music_volume = parsedResult.music_volume
		ambient_volume = parsedResult.ambient_volume
