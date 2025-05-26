extends CanvasLayer

@onready var main = $".."
var exit_blocked = false

# Close map on esc if sub tab not open
func _input(_event):
	if Input.is_action_just_pressed("Pause") and exit_blocked == false:
		close()
	if Input.is_action_just_released("Pause") and exit_blocked == false:
		main.pause_blocked = false



func open():
	main.pause_blocked = true
	show()

func close():
	hide()

