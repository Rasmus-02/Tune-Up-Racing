extends Panel
@export var part_stats : Control
var status = "closed"

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		close()

func open():
	status = "open"
	self.show()
	grab_focus()

func close():
	status = "closed"
	self.hide()
	release_focus()
	part_stats.grab_focus()


func _on_no_pressed():
	close()
