extends Node2D

#The Raycast Nodes
@export var forward_node : RayCast2D
@export var car_detector_node : Area2D
@export var forward_car_detector : RayCast2D
@export var left_90_node : RayCast2D
@export var left_45_node : RayCast2D
@export var right_90_node : RayCast2D
@export var right_45_node : RayCast2D
@export var car : CharacterBody2D

#The distances
var forward : float
var car_in_front : float
var left_90 : float
var left_45 : float
var right_90 : float
var right_45 : float
var closest_car = null

func _ready():
	#DISABLE SENSORS IF NOT AI
	if car.player == true:
		forward_node.enabled = false
		car_detector_node.monitoring = false
		car_detector_node.monitorable = false
		left_45_node.enabled = false
		right_45_node.enabled = false
		forward_car_detector.enabled = false

func _process(delta):
	right_90 = get_distance(right_90_node)
	left_90 = get_distance(left_90_node)
	if car.player == false:
		forward = get_distance(forward_node)
		car_in_front = get_distance(forward_car_detector)
		left_45 = get_distance(left_45_node)
		right_45 = get_distance(right_45_node)
		#area_handler()

#Function for getting the distance of a raycast colission
func get_distance(raycast):
	#If wall detected
	if raycast != null and raycast.is_colliding():
		var origin = raycast.global_transform.origin
		var collision_point = raycast.get_collision_point()
		var distance = origin.distance_to(collision_point)
		return distance
	#If no wall detected
	else:
		return 2560

func area_handler():
	var i = 0
	for bodies in car_detector_node.get_overlapping_bodies():
		i += 1
		if bodies.is_in_group("Car") and bodies != car:
			i -= 1
			closest_car = bodies
		elif i == car_detector_node.get_overlapping_bodies().size():
			closest_car = null


func _on_car_detector_body_entered(body):
	if body.is_in_group("Car") and body != car and closest_car == null:
		closest_car = body


func _on_car_detector_body_exited(body):
	if body == closest_car:
		closest_car = null
