extends TextureRect

@onready var map_name_label = $"Labels/Map Name"
@onready var worldmap = $".."
var selected_map : String


func _input(_event):
	if Input.is_action_just_pressed("Pause"):
		close()
	if Input.is_action_just_released("Pause"):
		await get_tree().process_frame
		worldmap.exit_blocked = false



func open(map_name):

	# Select correct map (for main function when "play" is pressed)
	selected_map = map_name
	# Block closing of worldmap
	worldmap.exit_blocked = true
	# Change the name and info about the map to correct info
	map_name_label.text = format_string(map_name)
	# Open the map info card
	show()

func close():
	hide()


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
