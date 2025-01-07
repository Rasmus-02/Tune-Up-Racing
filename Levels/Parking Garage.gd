extends Node2D

var car = preload("res://Assets/Car/Car.tscn")
@onready var spawn_positions = $"Car Spawn Positions"

func _ready():
	SelectedScene.scene = "parking_garage"
	get_parent().scene_changed()
	
	var car_spawn_position = null
	#Finds the key for a car that is in the garage
	if Save_Load.load_file("cars") != null:
		var spawn_pos = 0 #Gets updated for each car added (keeps track on where to spawn car)
		for n in Save_Load.load_file("cars"):
			var car_to_check = Save_Load.load_file("cars").get(str(n))
			if car_to_check != null: #look trough each car in dictionary
				if car_to_check.in_garage == null or car_to_check.in_garage == 0: #if the car is in the garage
					#Spawns the car
					car_spawn_position = spawn_positions.get_child(spawn_pos).global_position #Set which marker the car spawns at
					var new_car = car.instantiate()
					new_car.spawn_override_key = car_to_check.key #overrides so car does not spawn form selected car key
					self.add_child(new_car) #adds a new car
					new_car.global_position = car_spawn_position
					
					##TODO IN CAR SCRIPT AT is_loaded this gets called try to fix so cars spawn rotated when loaded
					if spawn_pos > 0:
						new_car.spawn_rotation = 180
					spawn_pos += 1
					
					if spawn_pos == 9: #Stop spawning cars if 10 cars spawned
						break


func _on_gate_body_entered(body):
	if body.is_in_group("Player"):
		SelectedScene.scene = "changing"
		get_parent().change_scene("garage")

func drive():
	get_parent().change_scene("costal_circuit")
