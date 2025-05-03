extends TextureButton

@onready var label = $Label

func _process(delta):
	if SelectedScene.scene == "garage":
		label.text = "Quit"
	else:
		label.text = "Garage"
