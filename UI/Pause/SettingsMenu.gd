extends Sprite2D

@export var general_settings : Control
@export var audio_settings : Control
@export var pause_menu : Sprite2D

func _ready():
	update_stats()

func _input(event):
	if visible and (Input.is_action_just_pressed("Pause") or Input.is_action_just_pressed("ui_cancel")):
		close()

func open():
	pause_menu.hide()
	self.show()
	_on_general_settings_pressed()

func close():
	pause_menu.show()
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
	#general.get_node("Resolution").select(Settings.resolution)
	general.get_node("V-Sync").select(Settings.vsync)
	
	audio.get_node("General Volume").value = Settings.general_volume
	audio.get_node("Car Volume").value = Settings.car_volume
	audio.get_node("Music Volume").value = Settings.music_volume
	audio.get_node("Ambient Volume").value = Settings.ambient_volume

# = Save the stats =============================================================
func _on_apply_pressed():
	var general = general_settings.get_child(0).get_node("Settings")
	var audio = audio_settings.get_child(0).get_node("Settings")
	
	Settings.camera_mode = general.get_node("Camera").get_selected_id()
	Settings.display_mode = general.get_node("Display").get_selected_id()
	#Settings.resolution = general.get_node("Resolution").get_selected_id()
	Settings.vsync = general.get_node("V-Sync").get_selected_id()
	
	Settings.general_volume = audio.get_node("General Volume").value
	Settings.car_volume = audio.get_node("Car Volume").value
	Settings.music_volume = audio.get_node("Music Volume").value
	Settings.ambient_volume = audio.get_node("Ambient Volume").value
	
	Settings.save_settings()
	close()

func _on_cancel_pressed():
	update_stats()
	close()
