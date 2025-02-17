extends Node2D

var id = [0,0,0,"Empty"] #Car ID, Part type, Part number, rank
var description = ""
var weight = 0.0
var downforce = 0.0
var drag = 0.0
var engine_cool_mod = 0.0
var boost_mod = 0.0
var turbo_intake = true
var supercharger_intake = true
var hp_mod = 0.0
var tq_mod = 0.0
var tq_mod_exhaust = 1.0
var supercharger = false
var supercharer_spool_rate = 0.0
var itb = false
var x_y = Vector2.ZERO
var drivetrain = 9999
var max_horsepower = 0.0
var max_torque = 0.0
var drivetrain_loss = 0.0
var compression = 0.0
var max_rpm = 0.0
var max_hp = 0.0
var max_tq = 0.0
var brake_force = 0.0
var brake_cooling = 0.0 #Celcius per second (road: 1-3, race: 2-5)
var brake_fade_limit = 0.0 #Degrees celcius
var handling_bonus = 0.0 #modifier *
var grip = 0.0
var treadwear = 0.0 #durabilityloss per second of driving
var wheelbase = 0.0
var cooling = 0.0
var max_hp_rpm = 0.0
var turbo = false
var supercharer_displacement_capacity = 0.0
var turbo_size = 0.0
var spool_rpm = 0.0
var gears = 5
var shift_time = 0.0
var gear_ratio = [0.0,0.0,0.0]
var smoothness = 0.0
var hp = 0.0
var tq = 0.0
var rarity = "common"
var Car_ID = 0
var Part_Number = 0
var type = 2
var lenght = 0
var width = 0
var orientation = "front"
var empty_space = 999
var max_compression = 0
var max_compression_modifier = 0
var layout = "Empty"
var turbo_1_size = 0.0
var turbo_2_size = 0.0
var turbo_3_size = 0.0
var turbo_4_size = 0.0
var exhaust_tq_mod = 1.0
var turbo_efficiency = 0.0
var turbo_type = "single"
var sequential_switch_rpm = 0
var pitch_tweak = 0.0
var sound_dampening = 0.0
var durability = 0 #0%
var color = 0
var price = 0
var diameter = 0
var max_tire_width = 0
var fuel_type = "Gasoline"
var gearbox_type = "No Gearbox"
var reliability = 1.0
func get_turbo_max_size():
	return 0



# ORPHAN NODE HANDLER, DELETE WHEN SCENE CHANGE
func _init():
	Utils.connect("freeing_orphans", Callable(self, "_free_if_orphaned"))
func _free_if_orphaned():
	if not is_inside_tree(): # Optional check - don't free if in the scene tree
		queue_free()
