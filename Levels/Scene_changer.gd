extends Node

@onready var track_view = $Track/Track_View
@onready var minimap = $UI/Minimap
# Maps
var costal_circuit = preload("res://Levels/Costal_Circuit.tscn")
var town_track = preload("res://Levels/Town_Track.tscn")
# Minimaps
var costal_circuit_minimap = preload("res://Textures/UI/Minimaps/Costal Circuit Minimap.png")
var town_track_minimap = preload("res://Textures/UI/Minimaps/Town Track Minimap.png")

func _ready(): #sets the scene to the scene that the script is attatched to
	SelectedScene.scene = get_child(0).name
	spawn_scene()

func spawn_scene():
	var track : PackedScene
	var main = get_tree().get_root().get_node("Main")
	var selected_track = main.current_scene_name
	
	# Select correct track and minimap
	print(selected_track)
	match selected_track:
		"costal_circuit":
			track = costal_circuit
			minimap.set_map_layout(costal_circuit_minimap)
		"town_track":
			track = town_track
			minimap.set_map_layout(town_track_minimap)
	
	
	track_view.add_child(track.instantiate())
