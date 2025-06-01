#region Import Export Modular Constructors etc.
extends Node2D
#Export var
signal stats(horsepower, torque, max_torque, top_end_fuel_type)
signal rpm_info(rpm, max_rpm)
var loaded = false

var player = true
@export var selected_block = 0
@export var selected_internals = 0
@export var selected_top = 0
@export var selected_intake_manifold = 0
@export var selected_exhaust_manifold = 0
@export var selected_air_filter = 0
@export var selected_engine = 0
@export var selected_engine_key = 0
@export var in_car = 0 #0 = in inventory, 1 = in a car
var block = null
var internals = null
var top = null
var intake_manifold = null
var exhaust_manifold = null
var air_filter = null
var rarity = null

var block_durability = 100
var internals_durability = 100
var top_durability = 100
var intake_manifold_durability = 100
var exhaust_manifold_durability = 100
var air_filter_durability = 100
var gearbox_displacement = Vector2(0,0)
var specific_parts = null 
var universal_parts = null 

var is_running = false


var wheel_speed = 1
var max_torque = 1 # * 1.3 to combat power losses
var fuel_type = "Gasoline"
var max_rpm = 1
var max_horsepower_rpm = 1
var max_compression = 0.0
var compression = 1 #:1
var max_boost = 1
var supercharger_pulley_size = 70.0
var turbo = false
var turbo_size = 1.0
var turbo_1_size = 1.0 #compressor size
var turbo_2_size = 1.0
var turbo_3_size = 1.0
var turbo_4_size = 1.0
var turbo_type = null
var turbo_efficiency = 1.0
var sequential_switch_rpm = 0
var supercharger = false
var supercharer_displacement_capacity = 1
var weight = 1
var width_left = 1
var width_right = 1
var lenght_front = 1
var lenght_rear = 1
var rpm = 1.0
var boost = 0.0
var boost_tq = 1.0
var horsepower = 1
var idle_rpm = 1000
var torque = 1
var dyno = 0
var gear_ratio = null
var gear = 1
var shift_cooldown = null
var engine_position = Vector2(0,0)
var drivetrain = null
var temperature = 0.0
var ambient_temperature = 20.0
var cooling = 0.0
var pitch_mod_car = 1.0
var volume_dampening_car = 0.0
var smoothness = 1.0
var tire_grip = 1.0
var forward : float
var backward : float
var left : float
var right : float
var clutch : float

var deleted = false
func delete_engine():
	deleted = true
	# Remove all instanses in local engine script
	var parts = [block, internals, top, intake_manifold, exhaust_manifold, air_filter]
	for i in parts.size():
		if parts[i] != null:
			parts[i].free()
	parts.clear()
	# Go into part selector and delete all instanses
	var part_selector = self.get_child(0).get_child(0).get_child(0)
	part_selector.reload_engine(true)
	specific_parts.queue_free()
	universal_parts.queue_free()
	self.queue_free()

func _init():
	Utils.connect("changing_scene", Callable(self, "_scene_changed"))
func _scene_changed():
	if get_parent().player == true:
		Save_Load.edit_engine(self)


var spawner = preload("res://Assets/Engine/Code/engine_spawner.tscn")
func load_engine(index):
	var load_file = Save_Load.select_engine(index)
	if load_file != null:
		#Loads engine from JSON
		selected_block = load_file.block[0]
		selected_internals = load_file.internals[0]
		selected_top = load_file.top[0]
		selected_intake_manifold = load_file.intake_manifold[0]
		selected_exhaust_manifold = load_file.exhaust_manifold[0]
		selected_air_filter = load_file.air_filter[0]
		selected_engine = load_file.engine_id
		selected_engine_key = load_file.key
		in_car = load_file.in_car
		#Damage stats
		block_durability = load_file.block[1]
		internals_durability = load_file.internals[1]
		top_durability = load_file.top[1]
		intake_manifold_durability = load_file.intake_manifold[1]
		exhaust_manifold_durability = load_file.exhaust_manifold[1]
		air_filter_durability = load_file.air_filter[1]
		max_boost = load_file.tune[0]
		max_rpm = load_file.tune[1]
	
	else:
		selected_block = 0
		selected_internals = 0
		selected_top = 0
		selected_intake_manifold = 0
		selected_exhaust_manifold = 0
		selected_air_filter = 0
		selected_engine = 0
		selected_engine_key = 0
		#Damage stats
		block_durability = 100
		internals_durability = 100
		top_durability = 100
		intake_manifold_durability = 100
		exhaust_manifold_durability = 100
		air_filter_durability = 100
	refresh_spawner()

func load_car_from_algorithm(dictionary):
	#Selected Parts
	selected_engine = dictionary.Engine_ID
	selected_block = dictionary.block
	selected_internals = dictionary.internals
	selected_top = dictionary.top
	selected_intake_manifold = dictionary.intake_manifold
	selected_exhaust_manifold = dictionary.exhaust_manifold
	selected_air_filter = dictionary.air_filter
	selected_engine_key = 9999
	in_car = 9999
	#Tune settings
	max_boost = dictionary.max_boost
	max_rpm = dictionary.max_rpm
	#Damage stats
	block_durability = 100
	internals_durability = 100
	top_durability = 100
	intake_manifold_durability = 100
	exhaust_manifold_durability = 100
	air_filter_durability = 100
	refresh_spawner()

func refresh_spawner():
	#Refresh Engine Spawner with a new Engine Spawner
	for n in self.get_children():
		self.remove_child(n)
		n.queue_free()
	var instance = spawner.instantiate()
	add_child(instance)
	update_engine_parts()

func update_engine_parts():
	#sends signal to part list to update engine
	if self.get_child(0).get_child(0) != null:
		#sends the updated parts to part list
		self.get_child(0).get_child(0).get_child(0).selected_block = selected_block
		self.get_child(0).get_child(0).get_child(0).selected_internals = selected_internals
		self.get_child(0).get_child(0).get_child(0).selected_top = selected_top
		self.get_child(0).get_child(0).get_child(0).selected_intake_manifold = selected_intake_manifold
		self.get_child(0).get_child(0).get_child(0).selected_exhaust_manifold = selected_exhaust_manifold
		self.get_child(0).get_child(0).get_child(0).selected_air_filter = selected_air_filter
		self.get_child(0).get_child(0).get_child(0).selected_engine = selected_engine
		self.get_child(0).get_child(0).get_child(0).selected_engine_key = selected_engine_key
		self.get_child(0).get_child(0).get_child(0).reload_engine(false)
	self.z_index = 30
	position_loaded = false
	engine_stats()

func engine_stats():
	var parts = [block, internals, top, intake_manifold, exhaust_manifold, air_filter]
	for i in parts.size():
		if parts[i] != null:
			parts[i].queue_free()
	parts.clear()
	
	specific_parts = get_child(0).get_child(0).get_child(0).get_child(0) #from part list specific to the engine
	universal_parts = get_child(0).get_child(0).get_child(0).get_child(1) #from universal part list (air filters)
	block = specific_parts.block[selected_block].instantiate()
	internals = specific_parts.internals[selected_internals].instantiate()
	top = specific_parts.top[selected_top].instantiate()
	intake_manifold = specific_parts.intake_manifold[selected_intake_manifold].instantiate()
	exhaust_manifold = specific_parts.exhaust_manifold[selected_exhaust_manifold].instantiate()
	air_filter = universal_parts.air_filter[selected_air_filter].instantiate()
	fuel_type = top.fuel_type
	max_torque = (durability_perfromance(block.tq, block_durability) * durability_perfromance(intake_manifold.tq_mod, intake_manifold_durability) 
	* durability_perfromance(exhaust_manifold.tq_mod, exhaust_manifold_durability) * durability_perfromance(top.tq_mod, top_durability) * durability_perfromance(air_filter.tq_mod, air_filter_durability))
	max_horsepower_rpm = durability_perfromance(top.max_hp_rpm / 1.2, top_durability) #/1.2 to make peak power accurate with the rest of the calculations
	max_compression = durability_perfromance(top.max_compression, top_durability) * durability_perfromance(intake_manifold.max_compression_modifier, intake_manifold_durability)
	compression = durability_perfromance(internals.compression, internals_durability)
	smoothness = durability_perfromance(top.smoothness, top_durability)
	turbo = exhaust_manifold.turbo
	supercharger = intake_manifold.supercharger
	turbo_1_size = exhaust_manifold.turbo_1_size
	turbo_2_size = exhaust_manifold.turbo_2_size
	turbo_3_size = exhaust_manifold.turbo_3_size
	turbo_4_size = exhaust_manifold.turbo_4_size
	turbo_type = exhaust_manifold.turbo_type
	turbo_efficiency = exhaust_manifold.turbo_efficiency
	sequential_switch_rpm = exhaust_manifold.sequential_switch_rpm
	supercharer_displacement_capacity = intake_manifold.supercharer_displacement_capacity
	weight = block.weight + internals.weight + top.weight + intake_manifold.weight + exhaust_manifold.weight + air_filter.weight
	rarity = get_node("Engine_spawner").current_engine[2]
	loaded = true
	
	#Damage stats !!! THIS UPDATES THE STATS IN THE ACTUAL PARTS !!! important because couldn't be changed from other scripts directly
	block.durability = block_durability
	internals.durability = internals_durability
	top.durability = top_durability
	intake_manifold.durability = intake_manifold_durability
	exhaust_manifold.durability = exhaust_manifold_durability
	air_filter.durability = air_filter_durability
		
	check_engine_structure()
	update_size()

func durability_perfromance(stat, durability):
	return (stat + stat * (durability * 0.0025)) * 0.8

func check_engine_structure():
	#Check so the engine structure is valid
	var refresh = false #goes true if engine strucutre is incorrect which refreshes the engine
	#Check that the engine is loaded because block can't be 0
	
	#Check that block isn't empty
	if selected_block == 0:
		if selected_internals != 0 or selected_top != 0 or selected_intake_manifold != 0 or selected_exhaust_manifold != 0 or selected_air_filter != 0:
			refresh = true
			selected_internals = 0
			selected_top = 0
			selected_intake_manifold = 0
			selected_exhaust_manifold = 0
			selected_air_filter = 0
	#Check that internals isn't empty
	if selected_internals == 0:
		if selected_top != 0 or selected_intake_manifold != 0 or selected_exhaust_manifold != 0 or selected_air_filter != 0:
			refresh = true
			selected_top = 0
			selected_intake_manifold = 0
			selected_exhaust_manifold = 0
			selected_air_filter = 0
	#Check that top isn't empty
	if selected_top == 0:
		if selected_intake_manifold != 0 or selected_exhaust_manifold != 0 or selected_air_filter != 0:
			refresh = true
			selected_intake_manifold = 0
			selected_exhaust_manifold = 0
			selected_air_filter = 0
	#Check that intake isn't empty and make sure it is the same layout as the manifold
	if (selected_intake_manifold == 0 and exhaust_manifold.turbo == false) or intake_manifold.layout != air_filter.layout:
		if selected_air_filter != 0:
			refresh = true
			selected_air_filter = 0

	#Add back parts that got removed to inventory
	if player == true:
		if selected_top == 0 and top.Part_Number != 0:
			Save_Load.inv_add(top)
		if selected_internals == 0 and internals.Part_Number != 0:
			Save_Load.inv_add(internals)
		if selected_intake_manifold == 0 and intake_manifold.Part_Number != 0:
			Save_Load.inv_add(intake_manifold)
		if selected_exhaust_manifold == 0 and exhaust_manifold.Part_Number != 0:
			Save_Load.inv_add(exhaust_manifold)
		if selected_air_filter == 0 and air_filter.Part_Number != 0:
			Save_Load.inv_add(air_filter)
		
		if refresh == true:
			update_engine_parts()

#IMPORT FROM CAR
func _on_car_export_variables(speed, ratio, gear_number, cooldown, e_position, drive_train_type, engine_pitch, engine_volume_dampening, grip, car_cooling, f,b,l,r,c):
	wheel_speed = speed
	gear_ratio = ratio
	gear = gear_number
	shift_cooldown = cooldown
	engine_position = e_position
	drivetrain = drive_train_type
	pitch_mod_car = engine_pitch
	volume_dampening_car = engine_volume_dampening
	tire_grip = grip
	cooling = car_cooling
	forward = f
	backward = b
	left = l
	right = r
	clutch = c

func _ready():
	var car = get_parent()
	if player == true and Save_Load.temp_key != null and (car.is_in_group("Car") and car.player == true):
		load_engine(Save_Load.temp_key)
	else:
		update_engine_parts()

func send_update():
	emit_signal("stats", horsepower, torque, max_torque, fuel_type)
	emit_signal("rpm_info", rpm, max_rpm)

func is_functional():
	if (selected_block != 0 and selected_top != 0 and selected_internals != 0 and selected_intake_manifold != 0 and selected_exhaust_manifold != 0 and selected_air_filter != 0 and 
	block_durability > 0 and top_durability > 0 and internals_durability > 0 and intake_manifold_durability > 0 and exhaust_manifold_durability > 0 and air_filter_durability > 0):
		return(true)
	elif is_running == true:
		get_child(0).get_child(0).get_node("EngineSmoke").get_child(0).emitting = true
		return(false)

var last_engine_position = null #To check if gearbox position gets changed
var last_drivetrain = null
func  _physics_process(_delta):
	send_update()
	if is_functional() and is_running == true and deleted == false:
		rpm_calculator()
		hp_tq_calculator()
		engine_temp()
		boost_calculator()
		if dyno != 1 and player == true:
			damage_calculator()
	else:
		is_running = false
		torque = 0
		horsepower = 0
		boost = 0
		rpm = 0
		temp_rpm = 0
		temperature = 0
		gear = 0
	if engine_position != Vector2.ZERO and (position_loaded == false or engine_position != last_engine_position or drivetrain != last_drivetrain) and deleted == false:
		last_engine_position = engine_position
		last_drivetrain = drivetrain
		set_engine_position()



var position_loaded = false
func set_engine_position():
	gearbox_displacement = get_child(0).get_child(0).get_node("Gearbox").position
	if drivetrain != 1: #rotate if longitudinal
		self.rotation = deg_to_rad(0)
		self.global_position = Vector2(engine_position.x - gearbox_displacement.x, engine_position.y) #X and Y needs to be swaooed at gearbox displacement
	else: #rotate if transverse
		self.rotation = deg_to_rad(-90)
		self.global_position = Vector2(engine_position.x, engine_position.y + gearbox_displacement.x)
	position_loaded = true
	rotate_exhausts()

func rotate_exhausts():
	var exhaust = get_child(0).get_child(0).get_child(0).get_child(6) #if things are changed in the specific engine scene the 2 might need changing
	if drivetrain != 1: #rotate if longitudinal and set exhaust acordingly
		if exhaust != null:
			exhaust.get_node("Trans").visible = false
			exhaust.get_node("Long").visible = true
	else: #rotate if transverse and set exhaust acordingly
		if exhaust != null:
			#print("Trans")
			exhaust.get_node("Trans").visible = true
			exhaust.get_node("Long").visible = false

func size_check(type, node):
	var engine_bay_size = null
	var engine_position_offset = null
	if get_parent() != null:
		engine_bay_size = get_parent().engine_bay_size
		engine_position_offset = get_parent().engine_position_offset
	
	var engine_offset = engine_position_offset
	var max_engine_width_left = 0
	var max_engine_width_right = 0
	var max_engine_lenght_forward = 0
	
	if drivetrain == 1: #if FWD
		max_engine_width_left = engine_offset.x
		max_engine_width_right = (engine_bay_size[0]) - engine_offset.x
		max_engine_lenght_forward = (engine_bay_size[1]*0.5) + engine_offset.y
	else:
		max_engine_width_left = (engine_bay_size[1]*0.5) + engine_offset.y
		max_engine_width_right = (engine_bay_size[1]*0.5) - engine_offset.y
		max_engine_lenght_forward = (engine_bay_size[0]) - engine_offset.x
	
	#Checks if the part will fit in the engine
	#WIDTH (exhaust manifold)
	if block.layout == "V": #different calc for V engines 
		if type == "exhaust_manifold":
			if block.width * 0.5 + node.width > max_engine_width_left or block.width * 0.5 + node.width > max_engine_width_right or block.lenght + node.lenght > max_engine_lenght_forward: #check so part doesn't fits in engine bay
				return false
			else:
				return true
		#intake
		if type == "intake_manifold":
			if block.lenght + node.lenght + air_filter.lenght > max_engine_lenght_forward: #check so part doesn't fits in engine bay
				return false
			else:
				return true
		if type == "air_filter":
			if block.lenght + node.lenght + intake_manifold.lenght > max_engine_lenght_forward: #check so part doesn't fits in engine bay
				return false
			else:
				return true
	else:
		if type == "exhaust_manifold":
			if block.width * 0.5 + node.width > max_engine_width_right or block.lenght + node.lenght > max_engine_lenght_forward: #check so part doesn't fits in engine bay
				return false
			else:
				return true
		#intake
		if type == "intake_manifold":
			if block.width * 0.5 + node.width > max_engine_width_left or block.lenght + node.lenght > max_engine_lenght_forward: #check so part doesn't fits in engine bay
				return false
			else:
				return true
	#LENGHT
	#block
	if type == "block":
		if node.lenght > max_engine_lenght_forward: #check so part doesn't fits in engine bay
			return false
		else:
			return true

func update_size():
	if block.layout == "V":
		if turbo == false:
			lenght_front = block.lenght + intake_manifold.lenght + air_filter.lenght
		else:
			lenght_front = block.lenght + exhaust_manifold.lenght
		width_left = block.width * 0.5 + exhaust_manifold.width
		width_right = block.width * 0.5 + exhaust_manifold.width
	else:
		if turbo == false:
			lenght_front = block.lenght + intake_manifold.lenght
		else:
			lenght_front = block.lenght + exhaust_manifold.lenght
		width_left = block.width * 0.5 + intake_manifold.width
		width_right = block.width * 0.5 + exhaust_manifold.width
	lenght_rear = 0



func part_placeable(type, node):
	#Check if there is a block
	if type == "internals":
		if selected_block != 0: 
			return true
		else:
			return false
	if type == "top":
		if selected_internals != 0: 
			return true
		else:
			return false
	#Check if there is a top
	if type == "exhaust_manifold" or type == "intake_manifold":
		if selected_top != 0: 
			return true
		else:
			return false
	#Check for attatchment point for air filter
	if type == "air_filter":
		if selected_exhaust_manifold != 0 and turbo == true and node.layout == "front":
			return true
		elif selected_intake_manifold != 0 and node.layout == intake_manifold.layout:
			return true
		else:
			return false
		
#endregion


#region Engine Physics
func damage_calculator():
	var damage_speed_mod = 0.0002
	##Block
	if torque > block.max_tq:
		block_durability -= (torque - block.max_tq) * damage_speed_mod
	##Internals
	if torque > internals.max_tq:
		internals_durability -= (torque - internals.max_tq) * damage_speed_mod
	if rpm > internals.max_rpm:
		internals_durability -= (rpm - internals.max_rpm) * damage_speed_mod
	##Knock
	var knock_damage = knock() * 0.01
	internals_durability -= knock_damage
	top_durability -= knock_damage * 0.5
	##Great Overpressure
	if knock() > 1:
		knock_damage * 1.5
	##Overheating (Temperature)
	if get_parent().player == true:
		pass
		#print(temperature)
	if temperature >= 110:
		block_durability -= (temperature - 110) * damage_speed_mod * 10
		internals_durability -= (temperature - 110) * damage_speed_mod * 10
		top_durability -= (temperature - 110) * damage_speed_mod * 10
		if turbo == true:
			exhaust_manifold_durability -= (temperature - 110) * damage_speed_mod * 10
	
	#Clamps
	block_durability = clamp(block_durability, 0, 100)
	internals_durability = clamp(internals_durability, 0, 100)
	top_durability = clamp(top_durability, 0, 100)
	exhaust_manifold_durability = clamp(exhaust_manifold_durability, 0, 100)
	
	#Change stats based on durability
	max_torque = (durability_perfromance(block.tq, block_durability) * durability_perfromance(intake_manifold.tq_mod, intake_manifold_durability) 
	* durability_perfromance(exhaust_manifold.tq_mod, exhaust_manifold_durability) * durability_perfromance(top.tq_mod, top_durability) * durability_perfromance(air_filter.tq_mod, air_filter_durability))
	max_horsepower_rpm = durability_perfromance(top.max_hp_rpm / 1.2, top_durability) #/1.2 to make peak power accurate with the rest of the calculations
	max_compression = durability_perfromance(top.max_compression, top_durability) * durability_perfromance(intake_manifold.max_compression_modifier, intake_manifold_durability)
	compression = durability_perfromance(internals.compression, internals_durability)
	smoothness = durability_perfromance(top.smoothness, top_durability)

var temp_rpm = 0 #Variasble to meassure differense between real rpm and clutch rpm
var real_rpm = 0
func rpm_calculator():
	#rpm based on wheelspeed if not in dyno
	if dyno == 0 or dyno == 2 or dyno == 3:
		if typeof(gear_ratio) == 28: #check that it is an array (28 == number for array)
			if shift_cooldown == false and (clutch <= 0 or dyno == 2 or dyno == 3):
				#index 0 in gear ratio is final drive
				real_rpm = (gear_ratio[gear - 1] * gear_ratio[0] * wheel_speed) * 10 #RPM is the gear ratio of selected gear multiplied by speed and constant
				rpm = temp_rpm
				if temp_rpm < real_rpm:
					temp_rpm += 100
				if temp_rpm > real_rpm:
					temp_rpm -= 100
				if abs(temp_rpm - real_rpm) < 200:
					temp_rpm = real_rpm
			elif forward > 0 and shift_cooldown == false and dyno == 0: #Throttle with clutch
				rpm += (100 * forward)
				temp_rpm = rpm
			elif rpm > idle_rpm: #as long as above idle
				rpm -= 25
				temp_rpm = rpm
	#rpm steadily increasing over time in dyno
	elif dyno == 1:
		is_running = true
		if Input.is_action_pressed("Forward"):
			forward = 1
			max_rpm = 4000
			max_boost = 2
			rpm += 15
		if Input.is_action_pressed("Backward"):
			forward = 0
			rpm -= 15
		#print(rpm, "    tq: ", torque, "    boost: ",boost)
	rpm = clamp(rpm, idle_rpm, max_rpm)


var h = 1 #h = boost coeficcient for hp
var t = 1 #t = boost coeficcient for tq
var gas = true


#New variables
var airflow_pre = 0
var airflow_post = 0
#variables for getting the boost generated by the turbo and the supercharger
var airflow_post_turbo = 0
var airflow_post_supercharger = 0
var boost_turbo = 0
var boost_supercharger = 0
var last_rpm = 0

func turbo_constructor():
	if turbo == true:
	#Turbo Constructors:
		#Single Turbo
		if turbo_type == "single":
			turbo_size = turbo_1_size
		
		#Paralell Turbos
		if turbo_type == "twin" or turbo_type == "quad": #Paralell turbos
			turbo_size = turbo_1_size + turbo_2_size + turbo_3_size + turbo_4_size
		
		#Sequential Turbos
		var large_turbo_size = 1.0
		var small_turbo_size = 1.0
		if turbo_type == "sequential_twin": #Sequential twin turbos
			large_turbo_size = turbo_1_size
			small_turbo_size = turbo_2_size
		if turbo_type == "sequential_quad": #Sequential quad turbos
			large_turbo_size = turbo_1_size + turbo_2_size
			small_turbo_size = turbo_3_size + turbo_4_size
		if (turbo_type == "sequential_twin" or turbo_type == "sequential_quad") and rpm < sequential_switch_rpm:
			turbo_size = small_turbo_size + (float(rpm ** 3) / float(sequential_switch_rpm ** 3)) * (large_turbo_size - small_turbo_size) #multiply from 0-1 the size difference between the small and large turbo for smooth transition

func boost_calculator():
	turbo_constructor()
	var turbo_boost_scale = 0.38
	if turbo == true: #=============================================================================
		if (forward > 0 or dyno == 2) and shift_cooldown != true and dyno != 3:
			if dyno == 2:
				forward = 1
			airflow_pre = torque
			boost_turbo += forward * (((((float(turbo_efficiency) / (((float(turbo_size)/50.0)**(3.0)))) * (airflow_pre/7000.0) * (float(rpm) / 1500.0)))) * turbo_boost_scale) #Bigger turbo or less efficient turbo = slower spool
			boost_turbo -= (((boost_turbo ** 3) / (turbo_size/50)**4) * turbo_boost_scale * 0.02) / turbo_efficiency
		else:
			airflow_pre = airflow_pre * 0.97
			boost_turbo = boost_turbo * 0.97
		last_rpm = rpm
		airflow_pre = clamp(airflow_pre, 0, 9999)
		var max_boost_mod = ((turbo_efficiency / (((turbo_size/60.0)**(2.0)))) * airflow_pre/50) * (turbo_boost_scale * 1.5) #| efficiency ++ boost | size -- boost | horsepower ++ boost| / 50is constant
		max_boost_mod += ((turbo_size * ((boost_turbo+1) ** 1.1))/500) * (turbo_boost_scale * 1.5)
		max_boost_mod = clamp(max_boost_mod, 0, max_boost)
		boost_turbo = clamp(boost_turbo, 0, max_boost_mod)
		airflow_post_turbo = (((turbo_size/60.0)**(0.8)) * boost_turbo) * 0.8 * air_filter.tq_mod #0.8 is constant to keep things realistic (otherwise to much boost)
	else:
		boost_turbo = 0.0
		airflow_post_turbo = 0.0
	
	if supercharger == true: #======================================================================
		var supercharger_loss = 0.0
		var pulley_size = supercharger_pulley_size / 35.0
		var loss_rate = 1.2
		if rpm > (max_horsepower_rpm / pulley_size):
			#Every rpm above supercharger pulley rpm setup leads to loss in boost
			supercharger_loss = ((((max_horsepower_rpm / pulley_size) - rpm) * loss_rate) / (max_horsepower_rpm / pulley_size)) * (supercharer_displacement_capacity * 0.0004)
		boost_supercharger = (rpm / (max_horsepower_rpm / pulley_size)) * (supercharer_displacement_capacity * 0.0004) + supercharger_loss
		boost_supercharger = clamp(boost_supercharger, 0, (max_horsepower_rpm / pulley_size))
		airflow_post_supercharger = boost_supercharger * 2 * air_filter.tq_mod
	else:
		boost_supercharger = 0.0
		airflow_post_supercharger = 0.0
	
	#combine the airflow and boost from the turbo and the supercharger
	boost = boost_turbo + boost_supercharger
	airflow_post = airflow_post_supercharger + (airflow_post_turbo * turbo_efficiency)

func engine_temp():
	var operating_temperature = 50 #idle temp
	temperature += 0.0125+(((horsepower + (boost * horsepower))/3) / 8000)/smoothness #2000 is constant, 3 is constant to make it so turbos don't affect temp too much
	temperature -= (temperature**1.5) / 60000 #temperature doesn't increase as much when reaching higher temps
	if temperature > operating_temperature:
		temperature -= cooling / 60.0

func hp_tq_calculator():
	#No Acceleration if hitting redline / rev limiter
	if rpm >= max_rpm or shift_cooldown:
		horsepower = 0
		torque = 0
	#Horsepower and torque is based of rpm
	else: 
		var low_end_torque = max_torque / 8.0 #used for making tq higher in low rpm
		torque = (max_torque * (rpm / max_horsepower_rpm)) + low_end_torque
		torque = (torque + (torque * airflow_post))/2.0 #for boost
		torque = ((torque * 2 - torque * (rpm / max_horsepower_rpm))/2.0) * 3.5 #powerloss due to friction
		torque = torque * (float(compression) / 10.0) #apply compression boost
		if compression + boost > max_compression:
			torque += (max_compression - (compression + boost)) * (50 * (1+boost)) #if over max compression start loosing power due to knock, lose more with more boost
		if turbo == true: #losses due to turbo restriction
			torque -= (((turbo_size/50.0)**(2.0)) * 6) / turbo_efficiency #*10 is constant, efficiensy makes less power loss
		if supercharger == true:
			torque -= supercharer_displacement_capacity / 22.0
		torque = clamp(torque, 0, 9999)
		
		horsepower = (torque * rpm) / 7127.0

func knock():
	if compression + boost > max_compression:
		return ((compression + boost) - max_compression) #Larger numbers = more knock
	else:
		return 0.0

func _on_engine_dyno_dyno_status(dyno_status):
	if dyno_status == 1:
		is_running = true
		dyno = 1

func estimate_torque():
	var temp_tq
	var temp_hp
	#Run twice, first time for hp, second time for tq
	var run1_hp
	var run1_tq
	for i in 1:
		var temp_rpm = max_horsepower_rpm
		var temp_turbo_size = exhaust_manifold.get_turbo_max_size()
		if i == 1:
			temp_rpm = max_horsepower_rpm * 0.77
		var temp_boost = max_boost
		var temp_airflow_post_turbo = 0
		var temp_airflow_post_supercharger = 0
		
		#Turbo Calc
		if turbo == true:
			temp_airflow_post_turbo = (((temp_turbo_size/60.0)**(0.8)) * temp_boost) * 0.8 * air_filter.tq_mod
		else:
			temp_boost = 0.0
		
		if supercharger == true:
			var pulley_size = supercharger_pulley_size / 35.0
			var loss_rate = 1.2
			var supercharger_loss = ((((max_horsepower_rpm / pulley_size) - temp_rpm) * loss_rate) / (max_horsepower_rpm / pulley_size)) * (supercharer_displacement_capacity * 0.0004)
			var temp_boost_supercharger = (temp_rpm / (max_horsepower_rpm / pulley_size)) * (supercharer_displacement_capacity * 0.0004) + supercharger_loss
			temp_boost_supercharger = clamp(temp_boost_supercharger, 0, (max_horsepower_rpm / pulley_size))
			temp_boost += temp_boost_supercharger
			temp_airflow_post_supercharger = temp_boost_supercharger * 2 * air_filter.tq_mod
		
		var temp_airflow_post = temp_airflow_post_supercharger + (temp_airflow_post_turbo * turbo_efficiency)
		
		
		temp_tq = max_torque * (float(temp_rpm) / float(max_horsepower_rpm)) + (max_torque / 8.0)
		temp_tq = (temp_tq + (temp_tq * temp_airflow_post))/2.0
		temp_tq = ((temp_tq * 2 - temp_tq * (temp_rpm / max_horsepower_rpm))/2.0) * 3.5 #powerloss due to friction
		temp_tq = temp_tq * (float(compression) / 10.0) #apply compression boost
		if compression + temp_boost > max_compression:
			temp_tq += (max_compression - (compression + temp_boost)) * (50 * (1+temp_boost)) #if over max compression start loosing power due to knock, lose more with more boost
		if turbo == true: #losses due to turbo restriction
			temp_tq -= (((temp_turbo_size/50.0)**(2.0)) * 6) / turbo_efficiency #*10 is constant, efficiensy makes less power loss
		if supercharger == true:
			temp_tq -= supercharer_displacement_capacity / 22.0
		
		temp_tq = clamp(temp_tq, 0, 9999)
		temp_hp = (temp_tq * temp_rpm) / 7127.0
		
		if i == 0:
			run1_tq = temp_tq
			run1_hp = temp_hp
	
	## If test with max rpm went better, use that
	temp_hp = run1_hp
	return {"tq" : int(temp_tq), "hp" : int(temp_hp)}
