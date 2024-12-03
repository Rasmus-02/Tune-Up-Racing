extends Node2D

var No_Engine = [preload("res://Assets/Engine/Engines/No Engine.tscn").instantiate(), "No Engine", "common"] #0
var Talon_Motors_Typhoon = [preload("res://Assets/Engine/Engines/Talon Motors Typhoon.tscn").instantiate(), "Talon Motors Typhoon", "rare"] #1
var Nagata_2S16i = [preload("res://Assets/Engine/Engines/Nagata 2S-16i.tscn").instantiate(), "Nagata 2S-16i", "uncommon"] #2
var Hikari_Suhei_25A = [preload("res://Assets/Engine/Engines/Hikari Suhei-25A.tscn").instantiate(), "Hikari Suhei-25A", "uncommon"] #3
var engine_list = [No_Engine, Talon_Motors_Typhoon, Nagata_2S16i, Hikari_Suhei_25A]
var current_engine = null

var max_torque = 1 # * 1.3 to combat power losses
var max_rpm = 1
var max_horsepower_rpm = 1
var compression = 1 #:1
var max_boost = 1
var turbo = false
var turbo_spool_rpm = max_horsepower_rpm * 0.4
var turbo_size = 1 #compressor size
var supercharger = false
var supercharer_spool_rate = 1
var shift_timer = null
var weight = 1
var width_left = 1
var width_right = 1
var lenght_front = 1
var lenght_rear = 1

var instance = null

func _ready():
	instantiate_engine()

func instantiate_engine():
	current_engine = engine_list[get_parent().selected_engine]
	print(current_engine)
	instance = current_engine[0]
	add_child(instance)
	get_parent().update_engine_parts()

func update():
	if current_engine != null:
		#Gets variables from engine ====================================================================
		current_engine = engine_list[get_parent().selected_engine]
		get_parent().engine_stats()
	#===============================================================================================
