extends Control

@export var grid : GridContainer
@export var center : Node2D

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		close()

func open():
	grid.populate_grid()
	self.global_position = get_parent().selected_car.global_position - Vector2(center.position.x, center.position.y)
	self.show()

func close():
	self.hide()
