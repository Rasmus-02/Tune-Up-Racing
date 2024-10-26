extends Node2D

@export var max_tiremarks : int
@export var detail : int 
@onready var tiremarks_close_node = $Tiremark_Close
@onready var tiremarks_far_node = $Tiremark_Far
var delay : int
var tiremark_count : int
var tiremarks_far = preload("res://Assets/Effects/tiremarks_far.tscn")
var tiremarks_far_instanse = null

func _ready():
	create_new_line()
#	var tiremark_close_instanse = tiremarks_close.instantiate()

#function for creating more lines
func create_new_line():
	delay = 999
	broken = false
	tiremarks_far_instanse = tiremarks_far.instantiate()
	tiremarks_far_node.add_child(tiremarks_far_instanse)


#Function for drawing tiremark, Call too draw line
var broken = false
func draw_tiremark(visible, wheel_position):
	if visible == false:
		broken = true
		tiremarks_close_node.clear_points()
	if broken == true and visible == true:
		create_new_line()
	
	if visible == true: #Draw tiremarks
		var point = wheel_position
		delay += 1
		#far line (less detailed)
		if delay >= detail: #set delay for less laggy lines to not add point every frame
			delay = 0 #reset delay
			#add point
			tiremark_count += 1
			tiremarks_far_instanse.add_point(point)
			manage_line_size()
		
		#Add and remove points from closer more detailed line2d
		tiremarks_close_node.add_point(point)
		if tiremarks_close_node.points.size() > detail + 1:
			tiremarks_close_node.remove_point(0)

func manage_line_size(): #limit line size
	if tiremark_count >= max_tiremarks:
		tiremarks_far_node.get_child(0).remove_point(0)
		tiremark_count -= 1
	
	if tiremarks_far_node.get_child(0).points.size() <= 0:
		tiremarks_far_node.get_child(0).queue_free()
