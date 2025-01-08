extends Node2D

@onready var pointer = $Pointer
@export var car : CharacterBody2D
@export var sensor : Node2D
var forward = 0.0
var backward = 0.0
var left = 0.0
var right = 0.0
@export_range(0.0, 1.0, 0.01) var brake_padding
@export_range(0.0, 1.0, 0.1) var turn_smoothing
@export_range(0.1, 1, 0.1) var gas_aggression
@export_range(0,200,5) var inaccuracy
@export_range(100, 300, 1) var breakoff_distance
var racing_line = null#: Line2D
var pursuing = false
var track_progress : float
var lap = 1.0

func import_racing_line(line_2d):
	racing_line = line_2d

func _physics_process(_delta):
	if SelectedScene.scene == "Track" and racing_line != null:
		get_next_point()
		var progress_1 = lap * 100000.0 #Make Lap the most important by making it 1000 times bigger that point weight
		var progress_2 = line_index * 100.0 #Make the points a large number to make them the main importance of progress
		var progress_3 = car.global_position.distance_to(racing_line.get_point_position(line_index))*0.0001 #Make the distance less important but is here if two cars are at same point
		track_progress = progress_1 + progress_2 - progress_3
		if car.player == false:
			point_to_racing_line()
			speed_controller()


#GAS BRAKES
func speed_controller():
	var traction = (car.tire_limit / car.max_tire_limit)
	#Brake
	var temp_forward = 0
	var temp_backward = 0
	var car_in_front
	var relative_velocity = 0
	#Get car distance
	if sensor.forward_car_detector.is_colliding() == true:
		car_in_front = sensor.forward_car_detector.get_collider()
		relative_velocity =  car.velocity.length() - car_in_front.velocity.length()
	#Brake if going to fast
	var velocity_difference = car.speed_kmh - get_max_speed()
	#velocity_difference = clamp(velocity_difference, -9999, 9999)
	if (global_position.distance_to(racing_line.get_point_position(line_index)) <= (get_brake_distance(velocity_difference) * 1.2)) and (car.velocity.length() >= 1 and sensor.forward != 0):
		forward = 0
		temp_backward = 1
		temp_backward = clamp(temp_backward, 0, 1)
	#Brake for other cars
	if (sensor.car_in_front <= get_brake_distance(relative_velocity * 2)  * (brake_padding + 1.5) and relative_velocity != 0 and relative_velocity > 0):
		forward = 0
		temp_backward = 1
		temp_backward = clamp(temp_backward, 0, 1)
	
	#Gas
	elif traction >= 0.5 and sensor.car_in_front > 300 and sensor.car_in_front != 0 and velocity_difference <= 0:
		backward = 0
		var gas = ((traction + 0.2) ** (1 - gas_aggression)) - (abs(get_next_point())**1.2 * (car.speed_kmh / 150.0))
		gas = clamp(gas, 0, 1)
		temp_forward = gas
	
	forward = temp_forward
	backward = temp_backward


#TURNING
var temp_point_pos = Vector2.ZERO
func point_to_racing_line():
	if get_next_point() > 0 and temp_point_pos != Vector2.ZERO:
		right = abs(get_next_point()) ** turn_smoothing
		right = clamp(right, 0, 1)
		left = 0
	elif  get_next_point() < 0 and temp_point_pos != Vector2.ZERO:
		left = abs(get_next_point()) ** turn_smoothing
		left = clamp(left, 0, 1)
		right = 0


#Returns the angel between the next point and the car
var line_index = 0
var inaccuracy_rng = 0
var overtake_rng = 1.0
var next_angle = 0
var offset_angle = deg_to_rad(0)
func get_next_point():
	#Get Next Point in optimal line
	var self_pos = car.global_position
	var max_angel = 20
	if self_pos.distance_to(racing_line.get_point_position(line_index) + Vector2(inaccuracy_rng,inaccuracy_rng)) < 700 or next_angle > deg_to_rad(120) or next_angle < deg_to_rad(-120) and self_pos.distance_to(racing_line.get_point_position(line_index) + Vector2(inaccuracy_rng,inaccuracy_rng)) < 4000:
		inaccuracy_rng = randf_range(-inaccuracy, inaccuracy)
		overtake_rng = randf_range(0.8, 1.2)
		#Reset when lap compleeted
		if line_index >= racing_line.get_point_count() - 1:
			line_index = 0
		line_index+=1
	#Drive Past Car in front
	if sensor.closest_car != null: #If not already in steep turn
		var offset_distance = 300 / overtake_rng
		var offset_direction = sensor.closest_car.velocity.normalized().rotated(offset_angle)
		var temp_car_dir = self_pos.direction_to(sensor.closest_car.global_position).angle() - self.global_rotation
		var oponent_sensors = sensor.closest_car.get_node("AI").get_node("Sensor")
		#Set the new target position to be in front to a suitable side of the opponent
		if sensor.right_90 > breakoff_distance and sensor.left_90 > breakoff_distance and sensor.right_45 > breakoff_distance * 1.4 and sensor.left_45 > breakoff_distance * 1.4 and car.wheels_on_road == 4 and sensor.closest_car.wheels_on_road == 4 and sensor.closest_car.get_node("AI").pursuing == false and car.player == false:
			temp_point_pos = sensor.closest_car.global_position + offset_direction * offset_distance
			pursuing = true
		else:
			temp_point_pos = racing_line.get_point_position(line_index) + Vector2(inaccuracy_rng,inaccuracy_rng)
		
		#Change which side it will overtake on
		if oponent_sensors.left_90 > 180 and sensor.left_90 < oponent_sensors.left_90 or oponent_sensors.right_90 <= 180: #Turn Left
			offset_angle = deg_to_rad(-25) * overtake_rng
		elif oponent_sensors.right_90 > 180 and sensor.right_90 < oponent_sensors.right_90 or oponent_sensors.left_90 <= 180: #Turn Right
			offset_angle = deg_to_rad(25) * overtake_rng
	else:
		temp_point_pos = racing_line.get_point_position(line_index) + Vector2(inaccuracy_rng,inaccuracy_rng)
	
	#Drive To next Point
	var dir = self_pos.direction_to(temp_point_pos)
	var angle = dir.angle()
	pointer.look_at(temp_point_pos)
	next_angle = pointer.rotation
	$"Sensor/AI TESTING TEMP POS".global_position = temp_point_pos
	return pointer.rotation


func get_max_speed():
	var node = racing_line.get_child(0).get_child(line_index-1)
	return int(node.get_text()) * get_performance_bonus()

func get_performance_bonus():
	#downforce and tire grip acounts for 27.6% and 27.6% of grip and the cars weight accounts for about 44.3% of the grip
	var downforce_bonus = ((car.downforce * car.rubberbanding + 800) / 1000) * 0.276 #+800 to account for the calculation scale bein correct because that is what the benschmark car used (200)
	var tirelimit_bonus = ((car.max_tire_limit / car.handling_bonus) / 1000) * 0.276 #/1000 to get a value of 1 (+- the % of tire grip)
	var weight_bonus = (1000 / car.weight) * 0.443 #1000 / car weight to get a value of 1 (+- the % of the cars weight)
	return (downforce_bonus + tirelimit_bonus + weight_bonus)

func get_brake_distance(car_speed):
	var brake_accel = car.max_braking_acceleration.length()
	var drag_accel = car.max_drag_acceleration.length()
	var speed = car_speed
	var distance = (speed**2) / (2 * (brake_accel + drag_accel))
	return distance

