extends Control

var display = preload("res://UI/Computer/car_detailed.tscn")
@export var car_list : VBoxContainer

func open(dict):
	get_parent().block_pause() #Block the back button from entering home screen
	car_list.clear_page()
	var new_display = display.instantiate()
	add_child(new_display)
	get_child(0).open(dict)

func close():
	get_parent().unblock_pause()
	for view in get_children():
		view.car_node.delete_car()
		view.queue_free()
		car_list.populate_page(car_list.page_number)


func _on_car_finder_pressed():
	close()


##CLEANER
func _ready():
	#Set script to "not pauseable"
	process_mode = Node.PROCESS_MODE_ALWAYS

# ORPHAN NODE HANDLER, DELETE WHEN SCENE CHANGE
func _init():
	Utils.connect("freeing_orphans", Callable(self, "_free_if_orphaned"))
func _free_if_orphaned():
	if not is_inside_tree(): # Optional check - don't free if in the scene tree
		for child in get_children():
			child.queue_free()
		queue_free()
