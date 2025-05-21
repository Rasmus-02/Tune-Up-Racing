extends Node2D

var weight = 1.0
var handling_bonus = 1.0
var grip = 1.0
var treadwear = 1.0 #durabilityloss per second of driving
var brake_force = 1.0
var downforce = 1.0
var drag = 1.0
var drivetrain = 0 #0=RWD, 1=FWD, 2=AWD
var drivetrain_loss = 1.0
var max_driveshaft_hp = 1
var max_driveshaft_tq = 1
var engine_cool_mod = 1.0
var brake_cooling = 1.0 #Celcius per second (road: 1-3, race: 2-5)
var brake_fade_limit = 1.0 #Degrees celcius (250-300 normal)
var wheelbase = 1
var engine_bay_size = [1,1]
var gear_ratio = 1
var max_gear = 1
var update = false
var engine_position = Vector2(0,0)
var engine_position_offset = Vector2(0,0)


func update_stats():
	#DONE=========================================================
	var node = get_node("Part Selector")
	var chassi = node.chassi
	var driveshaft = node.driveshaft
	var subframe = node.subframe
	var fenders = node.fenders
	var f_bumper = node.f_bumper
	var r_bumper = node.r_bumper
	var hood = node.hood
	var headlights = node.headlights
	var taillights = node.taillights
	var spoiler = node.spoiler
	var mirrors = node.mirrors
	var brakes = node.brakes
	var suspension = node.suspension
	var tires = node.tires
	var wheels = node.wheels
	var gearbox = node.gearbox
	var exhaust = node.exhaust
	var radiator = node.radiator
	#DONE=========================================================
