extends Node

var car_list = [] #Index 0 will be the player thanks to the level structure
#Array in array, inside array index 0 is car, index 1 is track_progress
var placing_list = []
var player_placing : int
var start = false

func _process(delta):
	if Input.is_action_just_pressed("Handbrake"):
		start = true
	
	#populate the placing list
	if start == true:
		set_placings()

func set_placings():
	var i = 0
	#Update the car list
	var temp_car_list = []
	for car in car_list:
		temp_car_list.append([car, car.get_node("AI").track_progress])
		i += 1
	
	#Sort the list acording to which car is first
	temp_car_list.sort_custom(func(a, b): return a[1] > b[1]) #Sort the cars according to track progress
	placing_list = temp_car_list
	#print(placing_list)
	update_car_placings()

func update_car_placings():
	for i in placing_list.size():
		var car = placing_list[i][0]
		if car == car_list[0]:
			player_placing = i+1
		car.get_node("Placing").car_placing = i+1
