extends Camera2D

var zoom_level = self.zoom
var zoom_mod = 0.8

func _ready():
	if $"..".player == false: #if AI
		enabled = false

func _physics_process(delta):
	var speed_mod = ($"..".velocity.length() / 15000) ** 0.6
	zoom_level.x = zoom_mod - speed_mod
	zoom_level.y = zoom_mod - speed_mod
	zoom_level.x = clamp(zoom_level.x, 0.2, zoom_mod)
	zoom_level.y = clamp(zoom_level.y, 0.2, zoom_mod)
	self.zoom = zoom_level
	self.global_position = get_parent().global_position + get_parent().velocity * 0.15
	
	#Set ignore rotation as true
	if Settings.camera_mode == 1 and ignore_rotation == true:
		ignore_rotation = false
