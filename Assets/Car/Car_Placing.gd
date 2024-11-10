extends Node2D

@export var car : CharacterBody2D
var car_placing : int
var performance_bonus = 1.0
var grip_bonus = 1.3
var difficulty = 1.15#1.15

func _process(delta):
	
	#Player
	if car.player == true:
		performance_bonus = 1.0
		grip_bonus = 1.0
	
	#Behind Player
	elif car_placing > Placing.player_placing:
		performance_bonus = 1.0 + ((car_placing - Placing.player_placing) * 0.005) ** 0.3
		performance_bonus *= difficulty
	
	#In front of player
	elif car_placing == Placing.player_placing - 1:
		performance_bonus = 1.0
		performance_bonus *= difficulty
	
	elif car_placing < Placing.player_placing - 1:
		performance_bonus = 1.0 - ((Placing.player_placing - car_placing) * 0.002) ** 0.4
		performance_bonus *= difficulty
