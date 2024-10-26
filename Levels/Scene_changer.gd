extends Node

func _ready(): #sets the scene to the scene that the script is attatched to
	SelectedScene.scene = get_child(0).name
