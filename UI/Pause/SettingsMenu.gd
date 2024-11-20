extends Sprite2D

@export var general_settings : Control
@export var audio_settings : Control

func _ready():
	update_stats()

func open():
	self.show()
	_on_general_settings_pressed()

func close():
	self.hide()

func hide_tabs():
	audio_settings.hide()
	general_settings.hide()

# = Main Tabs ==================================================================
func _on_general_settings_pressed():
	hide_tabs()
	general_settings.show()

func _on_audio_settings_pressed():
	hide_tabs()
	audio_settings.show()

# = Update the stats from Savefile =============================================
func update_stats():
	var general = general_settings.get_child(0).get_node("Settings")
	var audio = audio_settings.get_child(0).get_node("Settings")
	
	general.get_node("Camera").select(Settings.camera_mode)
	general.get_node("Display").select(Settings.display_mode)
	general.get_node("Resolution").select(Settings.resolution)
	general.get_node("V-Sync").select(Settings.vsync)
	
	audio.get_node("General Volume").value = Settings.general_volume
	audio.get_node("Car Volume").value = Settings.car_volume
	audio.get_node("Music Volume").value = Settings.music_volume
	audio.get_node("Ambient Volume").value = Settings.ambient_volume

