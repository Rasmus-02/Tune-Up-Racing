extends Control

@export var grid : GridContainer

func open():
	grid.populate_grid()
	self.show()

func close():
	self.hide()
