extends Node2D

var Nagata_Koi = [preload("res://Assets/Car/Cars/Nagata_Koi.tscn"), "Nagata Koi", "uncommon"] #0
var Talon_Motors_Barracuda = [preload("res://Assets/Car/Cars/Talon_Motors_Barracuda.tscn"), "Talon Motors Barracuda", "rare"] #1
var Hikari_Tasai = [preload("res://Assets/Car/Cars/Hikari Tasai.tscn"), "Hikari Tasai", "uncommon"] #2
var PWR_Wyvern = [preload("res://Assets/Car/Cars/PWR Wyvern.tscn"), "PWR Wyvern", "rare"] #3
var Holler_Q4 = [preload("res://Assets/Car/Cars/Holler Q4.tscn"), "Holler Q4", "common"] #4
var car_list = [Nagata_Koi, Talon_Motors_Barracuda, Hikari_Tasai, PWR_Wyvern, Holler_Q4]
var current_car = car_list[0] # [preload, name, rarity]

var weight = 0.0
var handling_bonus = 0.0
var grip = 0.0
var treadwear = 0.0 # durability loss per second of driving
var brake_force = 0.0
var downforce = 0.0
var drag = 0.0
var drivetrain = 0 # 0=RWD, 1=FWD, 2=AWD
var drivetrain_loss = 0.0
var max_driveshaft_hp = 0
var max_driveshaft_tq = 0
var engine_cool_mod = 0.0
var brake_cooling = 0.0 # Celcius per second (road: 1-3, race: 2-5)
var brake_fade_limit = 0.0 # Degrees celcius (250-300 normal)
var wheelbase = 0
var engine_bay_size = [1,1]
var gear_ratio = 1.0*100
var max_gear = 1
var shift_timer = null
var engine_position = Vector2(0,0)
var engine_position_offset = Vector2(0,0)

var instance = null


func instantiate_car():
	current_car = car_list[get_parent().selected_car]
	instance = current_car[0].instantiate()
	add_child(instance)

func reload_car():
	if get_children().size() != 0:
		get_child(0).queue_free()
	instantiate_car()


func update():
	if current_car != null:
		current_car = car_list[get_parent().selected_car]
		get_parent().update_stats() 
