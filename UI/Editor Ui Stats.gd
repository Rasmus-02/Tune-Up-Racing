extends Node2D

@onready var stat_tv1 = $"../../../Car Edit UI/Stat TV 1"
@onready var stat_tv2 = $"../../../Car Edit UI/Stat TV 2"
var stats : Array

func _ready():
	for i in 3:
		stats.append(stat_tv1.get_child(i))
	for i in 3:
		stats.append(stat_tv2.get_child(i))

func update_display(stat_label, stat, label : String, after_label : String):
	if stat == null:
		stat_label.text = " "
	else:
		stat_label.text = label + ": " + str(stat) + after_label

func change_part(part, type : String):
	match type:
		#Engine
		"block":
			update_display(stats[0], part.tq, "Torque", "Nm")
			update_display(stats[1], part.max_tq, "Max Torque", "Nm")
			update_display(stats[2], null, "", "")
			update_display(stats[3], null, "", "")
			update_display(stats[4], part.weight, "Weight", "Kg")
			update_display(stats[5], part.durability, "Durability", "%")
		"internals":
			update_display(stats[0], part.compression, "Compression", ":1")
			update_display(stats[1], part.max_tq, "Max Torque", "Nm")
			update_display(stats[2], part.max_rpm, "Max RPM", "RPM")
			update_display(stats[3], null, "", "")
			update_display(stats[4], part.weight, "Weight", "Kg")
			update_display(stats[5], part.durability, "Durability", "%")
		"top":
			update_display(stats[0], part.tq_mod * 100, "Efficiency", "%")
			update_display(stats[1], part.max_hp_rpm, "Peak RPM", "RPM")
			update_display(stats[2], part.max_compression, "Max Comp", ":1")
			update_display(stats[3], null, "", "")
			update_display(stats[4], part.weight, "Weight", "Kg")
			update_display(stats[5], part.durability, "Durability", "%")
		"exhaust_manifold":
			if part.turbo == true: #if turbo
				#("single", "twin", "sequential twin", "quad", "sequential quad") var turbo_type 
				var turbo
				match part.turbo_type:
					"single":
						turbo = "1 Turbo"
					"twin":
						turbo = "2 Turbos"
					"sequential_twin":
						turbo = "2seq Turbos"
					"quad":
						turbo = "4 Turbos"
					"sequential_quad":
						turbo = "4seq Turbos"
				update_display(stats[3], turbo, "Type", "")
				if part.turbo_type != "single":
					update_display(stats[1], part.turbo_1_size, "L Turbo", "mm")
					update_display(stats[2], part.turbo_2_size, "S Turbo", "mm")
				else:
					update_display(stats[1], part.turbo_1_size, "Turbo", "mm")
					update_display(stats[2], null, "", "")
				update_display(stats[0], (part.turbo_efficiency + part.tq_mod) * 50, "Efficiency", "%")
			else:
				update_display(stats[3], "NA", "Type", "")
				update_display(stats[1], null, "", "")
				update_display(stats[2], null, "", "")
				update_display(stats[0], part.tq_mod * 100, "Efficiency", "%")
			update_display(stats[4], part.weight, "Weight", "Kg")
			update_display(stats[5], part.durability, "Durability", "%")
		"intake_manifold":
			update_display(stats[0], part.tq_mod * 100, "Efficiency", "%")
			update_display(stats[1], part.max_compression_modifier * 100, "Max Comp", "%")
			if part.itb == true:
				update_display(stats[2], "ITB", "Type", "")
			elif part.supercharger == true:
				update_display(stats[2], "Supercharger", "Type", "")
			elif part.layout == "top":
				update_display(stats[2], "Carburator", "Type", "")
			else:
				update_display(stats[2], "EFI", "Type", "")
			if part.supercharger == true:
				update_display(stats[3], part.supercharer_displacement_capacity, "Capacity", "CC")
			else:
				update_display(stats[3], null, "", "")
			update_display(stats[4], part.weight, "Weight", "Kg")
			update_display(stats[5], part.durability, "Durability", "%")
		"air_filter":
			update_display(stats[0], part.tq_mod * 100, "Efficiency", "%")
			update_display(stats[1], null, "", "")
			update_display(stats[2], null, "", "")
			update_display(stats[3], null, "", "")
			update_display(stats[4], part.weight, "Weight", "Kg")
			update_display(stats[5], part.durability, "Durability", "%")
		
		#Car
		"1", "4", "6": #front bumper, hood, headlights
			update_display(stats[0], part.downforce, "Downforce", "Kg")
			update_display(stats[1], part.engine_cool_mod, "Cooling", "C°/s")
			update_display(stats[2], null, "", "")
			update_display(stats[3], part.drag, "Drag", "")
			update_display(stats[4], part.weight, "Weight", "Kg")
			update_display(stats[5], part.durability, "Durability", "%")
		"2", "3", "5", "8": #rear bumper, fenders, mirrors, spoiler
			update_display(stats[0], part.downforce, "Downforce", "Kg")
			update_display(stats[1], null, "", "")
			update_display(stats[2], null, "", "")
			update_display(stats[3], part.drag, "Drag", "")
			update_display(stats[4], part.weight, "Weight", "Kg")
			update_display(stats[5], part.durability, "Durability", "%")
		"7": #taillights
			update_display(stats[0], null, "", "")
			update_display(stats[1], null, "", "")
			update_display(stats[2], null, "", "")
			update_display(stats[3], null, "", "")
			update_display(stats[4], part.weight, "Weight", "Kg")
			update_display(stats[5], part.durability, "Durability", "%")
		"9", "13": #suspension, subframe
			update_display(stats[0], int(part.handling_bonus * 100), "Handling", "%")
			update_display(stats[1], null, "", "")
			update_display(stats[2], null, "", "")
			update_display(stats[3], null, "", "")
			update_display(stats[4], part.weight, "Weight", "Kg")
			update_display(stats[5], part.durability, "Durability", "%")
		"10": #wheels
			update_display(stats[0], part.brake_cooling, "Cooling", "C°/s")
			update_display(stats[1], null, "", "")
			update_display(stats[2], null, "", "")
			update_display(stats[3], null, "", "")
			update_display(stats[4], part.weight, "Weight", "Kg")
			update_display(stats[5], part.durability, "Durability", "%")
		"11": #tires
			update_display(stats[0], int(part.grip * 0.1), "Traction", "%")
			update_display(stats[1], int(part.treadwear * 10000), "Treadwear", "")
			update_display(stats[2], null, "", "")
			update_display(stats[3], null, "", "")
			update_display(stats[4], part.weight, "Weight", "Kg")
			update_display(stats[5], part.durability, "Durability", "%")
		"12": #brakes
			update_display(stats[0], int(part.brake_force * 14), "Braking", "N")
			update_display(stats[1], part.brake_cooling, "Cooling", "C°/s")
			update_display(stats[2], part.brake_fade_limit, "Fade @", "C°")
			update_display(stats[3], null, "", "")
			update_display(stats[4], part.weight, "Weight", "Kg")
			update_display(stats[5], part.durability, "Durability", "%")
		"14": #driveshaft
			match part.drivetrain:
				0:
					update_display(stats[0], "RWD", "Type", "")
				1:
					update_display(stats[0], "FWD", "Type", "")
				2:
					update_display(stats[0], "AWD", "Type", "")
				
			update_display(stats[1], part.max_torque, "Max Torque", "Nm")
			update_display(stats[2], part.drivetrain_loss, "Power Loss", "%")
			update_display(stats[3], null, "", "")
			update_display(stats[4], part.weight, "Weight", "Kg")
			update_display(stats[5], part.durability, "Durability", "%")
		"15": #gearbox
			match part.drivetrain:
				0:
					update_display(stats[0], "RWD", "Type", "")
				1:
					update_display(stats[0], "FWD", "Type", "")
				2:
					update_display(stats[0], "AWD", "Type", "")
				
			update_display(stats[1], part.max_tq, "Max Torque", "Nm")
			update_display(stats[2], part.gear_ratio.size() - 1, "Gears", "")
			update_display(stats[3], part.shift_time, "Shift Speed", "s")
			update_display(stats[4], part.weight, "Weight", "Kg")
			update_display(stats[5], part.durability, "Durability", "%")
		"16": #radiator
			update_display(stats[0], part.cooling, "Cooling", "C°/s")
			update_display(stats[1], null, "", "")
			update_display(stats[2], null, "", "")
			update_display(stats[3], null, "", "")
			update_display(stats[4], part.weight, "Weight", "Kg")
			update_display(stats[5], part.durability, "Durability", "%")
		"17": #exhaust
			update_display(stats[0], (part.tq_mod * 100), "Efficiency", "%")
			update_display(stats[1], part.sound_dampening, "Dampening", "dB")
			update_display(stats[2], null, "", "")
			update_display(stats[3], null, "", "")
			update_display(stats[4], part.weight, "Weight", "Kg")
			update_display(stats[5], part.durability, "Durability", "%")

