extends Node2D

var progress = []
var sceneName
var scene_load_status = 0
@onready var load_status_ui = $Control/Load_status
@onready var load_bar_ui = $Control/Load_status/AnimatedSprite2D

func _ready():
	sceneName = SelectedScene.next_scene
	ResourceLoader.load_threaded_request(sceneName)

func _process(delta):
	scene_load_status = ResourceLoader.load_threaded_get_status(sceneName, progress)
	load_status_ui.text = str(floor(progress[0]*100)) + "%"
	load_bar_ui.frame = int(floor(progress[0]*10))
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var newScene = ResourceLoader.load_threaded_get(sceneName)
		get_tree().change_scene_to_packed(newScene)

