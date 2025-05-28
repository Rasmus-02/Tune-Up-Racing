extends Node

@onready var track_view = $Track/Track_View
var costal_circuit = preload("res://Levels/Costal_Circuit.tscn")
var town_track = preload("res://Levels/Town_Track.tscn")

func _ready(): #sets the scene to the scene that the script is attatched to
	SelectedScene.scene = get_child(0).name
	spawn_scene()

func spawn_scene():
	var track : PackedScene
	var main = get_tree().get_root().get_node("Main")
	var selected_track = main.current_scene_name
	
	# Select correct track
	print(selected_track)
	match selected_track:
		"costal_circuit":
			track = costal_circuit
		"town_track":
			track = town_track
	
	
	track_view.add_child(track.instantiate())
