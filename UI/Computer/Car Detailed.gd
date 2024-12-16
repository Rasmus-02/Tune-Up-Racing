extends Panel

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		close()

func open(dict):
	show()

func close():
	hide()
