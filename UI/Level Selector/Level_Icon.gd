extends Control

@export var new_event_icon : Sprite2D
@export var map_info : TextureRect
@export var map_name : String

func _ready():
	new_event_icon.hide()

func _on_pressed():
	map_info.open(map_name)
