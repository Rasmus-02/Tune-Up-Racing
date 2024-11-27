extends Node2D

var forward : float
var backward : float
var left : float
var right : float
var clutch : float
var handbrake : float

@export var car : CharacterBody2D

func _process(_delta):
	if car.player == true:
		get_inputs()
		vibrate_controller(1 - (car.tire_limit / car.max_tire_limit))

func get_inputs():
	backward = Input.get_action_strength("Backward")
	forward = Input.get_action_strength("Forward")
	left = Input.get_action_strength("Left")
	right = Input.get_action_strength("Right")
	clutch = Input.get_action_strength("Clutch")
	handbrake = Input.get_action_strength("Handbrake")
	forward = clamp(forward,0,1)
	backward = clamp(backward,0,1)
	left = clamp(left,0,1)
	right = clamp(right,0,1)

func vibrate_controller(strenght):
	var vibration = (strenght ** 1.5) * 0.02
	var vibration_2 = (strenght ** 4) * 0.02
	Input.start_joy_vibration(0,vibration,vibration_2,1)
