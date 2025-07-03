extends Node

var car_list = [] #Index 0 will be the player thanks to the level structure
#Array in array, inside array index 0 is car, index 1 is track_progress
var placing_list = []
var player_placing : int
var start = false
var max_lap = 3 #Can set max lap count here
var max_score = 200000 # Set the score needed in drift event for #1 rank
var max_time = 200000 # Set the time needed in timeattack for #1 rank
var map_bonus = 1.0
var player_lap = 0

func _ready():
	#Set script to "not pauseable"
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(_delta):
	#populate the placing list
	if RaceStatus.started and RaceStatus.finished == false:
		set_placings()

func set_placings():
	#Update the car list
	var temp_car_list = []
	temp_car_list.clear()
	for car in car_list:
		temp_car_list.append([car, car.get_node("AI").track_progress])
	
	#Sort the list acording to which car is first
	temp_car_list.sort_custom(func(a, b): return a[1] > b[1]) #Sort the cars according to track progress
	placing_list = temp_car_list
	#print(placing_list)
	update_car_placings()
	update_player_lap()

func update_car_placings():
	for i in placing_list.size():
		var car = placing_list[i][0]
		if car == car_list[0]:
			player_placing = i+1
		car.get_node("Placing").car_placing = i+1

func update_player_lap():
	if car_list.size() > 0:
		player_lap = int(car_list[0].get_node("AI").lap)
		player_lap = clamp(player_lap, 1, max_lap)
