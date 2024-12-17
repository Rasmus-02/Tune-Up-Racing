extends Control

var display = preload("res://UI/Computer/car_detailed.tscn")
@export var car_list : VBoxContainer

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		close()

func open(dict):
	var new_display = display.instantiate()
	add_child(new_display)
	get_child(0).open(dict)

func close():
	for view in get_children():
		view.queue_free()
		car_list.populate_page(car_list.page_number)



func _on_car_finder_pressed():
	close()
