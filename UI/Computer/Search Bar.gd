extends TextEdit

#Disables Tab and Enter
func _input(event):
	if has_focus():
		if event is InputEventKey and event.is_pressed():
			if event.keycode == KEY_TAB or event.keycode == KEY_ENTER:
				get_viewport().set_input_as_handled()
