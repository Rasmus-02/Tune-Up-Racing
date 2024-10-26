extends Node2D

var car = preload("res://Assets/Car/Car.tscn")
var lift_car = null #the car that is on the lift
var dyno_car = null
@onready var spawn_positions = $"Car Spawn Positions"

func _on_car_1_pressed():
	pass # Replace with function body.
func _on_car_2_pressed():
	pass # Replace with function body.
func _on_car_3_pressed():
	pass # Replace with function body.

func _ready():
	var car_spawn_position = null
	#Finds the key for a car that is in the garage
	if Save_Load.load_file("cars") != null:
		for n in Save_Load.load_file("cars"):
			var car_to_check = Save_Load.load_file("cars").get(str(n))
			if car_to_check != null: #look trough each car in dictionary
				if car_to_check.in_garage > 0: #if the car is in the garage
					#Spawns the car
					car_spawn_position = spawn_positions.get_child(car_to_check.in_garage - 1).global_position #Set which marker the car spawns at
					var new_car = car.instantiate()
					new_car.spawn_override_key = car_to_check.key #overrides so car does not spawn form selected car key
					self.add_child(new_car) #adds a new car
					if car_to_check.in_garage == 1:
						lift_car = new_car
					elif car_to_check.in_garage == 2:
						dyno_car = new_car
					new_car.global_position = car_spawn_position

func move_car(car_to_move):
	car_to_move.global_position = spawn_positions.get_child(car_to_move.in_garage - 1).global_position
	if car_to_move.in_garage == 1:
		lift_car = car_to_move
	elif car_to_move.in_garage == 2:
		dyno_car = car_to_move
		print(dyno_car)
