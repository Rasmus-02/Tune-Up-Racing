class_name generator
extends Node
var difficulty = 1.35

#Main Functions
func generate_car(rarity, weight, torque_estimate, grip, downforce, brake_force, precision):
	torque_estimate = torque_estimate * difficulty
	grip *= difficulty
	downforce *= difficulty
	brake_force *= difficulty
	
	#Find Suitable Chassi
	var car_array = []
	var universal = AssetList.car_list.get_child(0)
	for i in AssetList.car_list.get_child_count()-1: #-1 and +1 is to offset universal part list
		#Make sure chassi in range for rarity and weight (75% is the estimated chassi weight of the total car)
		var car = AssetList.car_list.get_child(i+1)
		var instance = car.chassi[0].instantiate()
		if instance.weight > (weight * precision) * 0.70 and instance.weight < (weight / precision) * 0.75 and instance.rarity == rarity:
			car_array.append(car)
		instance.queue_free()
	if car_array.size() != 0:
		randomize()
		var rng = randi_range(0, car_array.size() - 1) #Pick A Random Chassi from the array
		var car_model = car_array[rng]
		#print(" ")
		#print("Car array: ",car_array)
		#print("Car model: ",car_model)
		
		#Find proper parts for the chassi
		var chassi = car_model.chassi[0].instantiate()
		var driveshaft = _find_suitable_part("driveshaft", car_model.driveshaft, null, null, null)
		var gearbox = _find_suitable_part("gearbox", universal.gearbox, [driveshaft.drivetrain,driveshaft.drivetrain], null, null)
		var fenders = _find_suitable_part("fenders", car_model.fenders, null, [grip, (grip / precision)*1.2], null)
		var wheels = _find_suitable_part("wheels", universal.wheels, null, [0,fenders.max_tire_width], null)
		var tires = _find_suitable_part("tires", universal.tires,  [grip * precision, (grip / precision)*1.2], [0,wheels.max_tire_width], null)
		var f_bumper = _find_suitable_part("f_bumper", car_model.f_bumper, [0, (downforce)], null, null)
		var spoiler = _find_suitable_part("spoiler", car_model.spoiler, [(downforce * 0.8 - f_bumper.downforce) * precision, (downforce *1.2 - f_bumper.downforce) / precision], null, null)
		var headlight = _find_suitable_part("headlights", car_model.headlights, null, null, null)
		var taillights = _find_suitable_part("taillights", car_model.taillights, null, null, null)
		var mirrors = _find_suitable_part("mirrors", car_model.mirrors, null, null, null)
		var subframe = _find_suitable_part("subframe", car_model.subframe, null, null, null)
		var exhaust = _find_suitable_part("exhaust", car_model.exhaust, null, null, null)
		var brakes = _find_suitable_part("brakes", universal.brakes, [brake_force * precision , brake_force / precision], null, null)
		var suspension = _find_suitable_part("suspension", universal.suspension, null, null, null)
		var radiator = _find_suitable_part("radiator", universal.radiator, null, null, null)
		
		var car_weight = car_model.chassi[0].instantiate().weight + driveshaft.weight + gearbox.weight + fenders.weight + wheels.weight + tires.weight + spoiler.weight + f_bumper.weight + headlight.weight + taillights.weight + mirrors.weight + subframe.weight + exhaust.weight + brakes.weight + suspension.weight + radiator.weight
		#print(car_weight)
		var r_bumper = _find_suitable_part("r_bumper", car_model.r_bumper, [0, weight - car_weight], null, null)
		#print(r_bumper.weight)
		var hood = _find_suitable_part("hood", car_model.hood, [0, weight - car_weight], null, null)
		#print(hood.weight)
		car_weight += hood.weight + r_bumper.weight
		
		var engine_position_offset = Vector2.ZERO
		var engine_bay_size = [chassi.engine_bay_lenght - radiator.width, chassi.engine_bay_width]
		if driveshaft.drivetrain == 1: #FWD 
			engine_position_offset = Vector2(gearbox.get_node("Engine").position.y + driveshaft.get_node("Gearbox").position.x - chassi.engine_bay_start_lenght, driveshaft.get_node("Gearbox").position.y - gearbox.get_node("Engine").position.x)
		else: #RWD AWD
			engine_position_offset = Vector2(gearbox.get_node("Engine").position.x + driveshaft.get_node("Gearbox").position.x - chassi.engine_bay_start_lenght, driveshaft.get_node("Gearbox").position.y - gearbox.get_node("Engine").position.y)
		
		
		return{"Car_ID" : driveshaft.Car_ID,
		"weight" : car_weight,
		"position_offset" : engine_position_offset,
		"engine_bay_size" : engine_bay_size,
		"stock_engine" : car_model.stock_engine,
		"drivetrain" : driveshaft.drivetrain,
		"driveshaft" : driveshaft.Part_Number,
		"gearbox" : gearbox.Part_Number,
		"fenders" : fenders.Part_Number,
		"wheels" : wheels.Part_Number,
		"tires" : tires.Part_Number,
		"spoiler" : spoiler.Part_Number,
		"f_bumper" : f_bumper.Part_Number,
		"r_bumper" : r_bumper.Part_Number,
		"headlight" : headlight.Part_Number,
		"taillights" : taillights.Part_Number,
		"mirrors" : mirrors.Part_Number,
		"hood" : hood.Part_Number,
		"subframe" : subframe.Part_Number,
		"exhaust" : exhaust.Part_Number,
		"brakes" : brakes.Part_Number,
		"suspension" : suspension.Part_Number,
		"radiator" : radiator.Part_Number,}

func generate_engine(weight, car_weight, torque, engine_bay_size, engine_offset, drivetrain, stock_engine, precision):
	torque *= difficulty
	
	randomize()
	var max_lenght
	var max_width_l
	var max_width_r
	if drivetrain == 1: #if FWD
		max_width_l = engine_offset.x
		max_width_r = (engine_bay_size[0]) - engine_offset.x
		max_lenght = (engine_bay_size[1]*0.5) + engine_offset.y
	else:
		max_width_l = (engine_bay_size[1]*0.5) + engine_offset.y
		max_width_r = (engine_bay_size[1]*0.5) - engine_offset.y
		max_lenght = (engine_bay_size[0]) - engine_offset.x
	
	#Find Suitable Engine
	var engine_array = []
	var universal = AssetList.engine_list.get_child(0)
	var max_weight = weight - car_weight #The max weight for the engine
	var stock_or_swapped = randi_range(0, 10)
	#Use Stock Engine
	if stock_or_swapped <= 5:
		var engine = AssetList.engine_list.get_child(stock_engine) #get engine at index specified in car part list
		engine_array.append(engine)
	#Find a swappable engine
	else:
		for i in AssetList.engine_list.get_child_count()-1: #-1 and +1 is to offset universal part list
			#Make sure engine in range weight (15% is the estimated chassi weight of the total car), and that there is a block that can handle the torque
			var engine = AssetList.engine_list.get_child(i+1)
			var instance = engine.block[1].instantiate()
			if instance.lenght < max_lenght and instance.width * 0.5 < max_width_l and instance.width * 0.5 < max_width_r:
				engine_array.append(engine)
			instance.queue_free()
	if engine_array.size() != 0:
		var rng = randi_range(0, engine_array.size() - 1) #Pick A Random Chassi from the array
		var engine_model = engine_array[rng]
		
		var est_tq = 0 #Estimated Torque
		var est_tq_nb = 0 #Estimated Torque Without boost
		var boost_estimate_total = 0.0
		var boost_estimate_turbo = 0.0
		var block = _find_suitable_part("block", engine_model.block, [torque, 9999], null, null)
		est_tq += block.tq
		est_tq_nb += block.tq
		var intake_manifold = _find_suitable_part("intake_manifold", engine_model.intake_manifold, [0,torque], [0,max_width_l - block.width * 0.5], est_tq)
		if intake_manifold.supercharger == true:
			boost_estimate_total += (intake_manifold.supercharer_displacement_capacity * 0.0004)
			est_tq += (intake_manifold.supercharer_displacement_capacity * 0.0004)
		est_tq *= intake_manifold.tq_mod
		est_tq_nb *= intake_manifold.tq_mod
		var exhaust_manifold = _find_suitable_part("exhaust_manifold", engine_model.exhaust_manifold, [torque * precision, torque / precision], [0,max_width_r - block.width * 0.5], [est_tq, torque, est_tq_nb, intake_manifold.layout])
		if exhaust_manifold.turbo == true:
			boost_estimate_turbo = _estimate_boost(est_tq, est_tq_nb, torque, exhaust_manifold.get_turbo_max_size(), exhaust_manifold.turbo_efficiency)
			boost_estimate_total += boost_estimate_turbo
			est_tq += est_tq * (boost_estimate_turbo * (exhaust_manifold.get_turbo_max_size()/70)*exhaust_manifold.turbo_efficiency) #Estimate turbo power
		est_tq *= exhaust_manifold.tq_mod
		est_tq_nb *= exhaust_manifold.tq_mod
		var internals = _find_suitable_part("internals", engine_model.internals, [torque / precision, 9999], [boost_estimate_total, 9999], est_tq)
		est_tq = est_tq * (internals.compression / 10)
		est_tq_nb = est_tq_nb * (internals.compression / 10)
		boost_estimate_total += internals.compression
		var top = _find_suitable_part("top", engine_model.top, [est_tq * precision, est_tq / precision], [boost_estimate_total, 9999], est_tq)
		est_tq *= top.tq_mod
		est_tq_nb *= top.tq_mod
		#Set air filter position to wanted position
		var air_filter_layout = intake_manifold.layout
		if exhaust_manifold.turbo == true:
			air_filter_layout = "front"
		var air_filter = _find_suitable_part("air_filter", universal.air_filter, null, [air_filter_layout, air_filter_layout], null)
		est_tq *= air_filter.tq_mod
		est_tq_nb *= air_filter.tq_mod
		
		#Increasing the accuracy of turbocharged engines
		if exhaust_manifold.turbo == true:
			#For adding back supercharger and compression
			var tq_sc_nb = est_tq_nb
			tq_sc_nb = est_tq_nb * (internals.compression / 10)
			if intake_manifold.supercharger == true:
				tq_sc_nb += (intake_manifold.supercharer_displacement_capacity * 0.0004)
			boost_estimate_turbo = _estimate_boost(tq_sc_nb ,est_tq_nb, torque, exhaust_manifold.get_turbo_max_size(), exhaust_manifold.turbo_efficiency)
			tq_sc_nb += est_tq_nb * (boost_estimate_turbo * (exhaust_manifold.get_turbo_max_size()/70)*exhaust_manifold.turbo_efficiency) #Estimate turbo power
			est_tq = tq_sc_nb
		
		
		#If any engine part is not within size limits, return null to generate new engine
		#block
		#print("length: ", max_lenght, "  right: ", max_width_r, "  left: ",max_width_l)
		#print("exhaust width: ", block.width * 0.5 + exhaust_manifold.width)
		if block.lenght > max_lenght: #check so part doesn't fits in engine bay
			return(null)
			#print("Block too long")
		#V ENGINES
		if block.layout == "V": #different calc for V engines 
			#Exhaust Manifold
			if block.width * 0.5 + exhaust_manifold.width > max_width_l or block.width * 0.5 + exhaust_manifold.width > max_width_r or block.lenght + exhaust_manifold.lenght > max_lenght: #check so part doesn't fits in engine bay
				#print("exhaust manifold to large")
				return(null)
			#Intake Manifold
			if block.lenght + intake_manifold.lenght + air_filter.lenght > max_lenght: #check so part doesn't fits in engine bay
				#print("intake manifold to large  ", intake_manifold, "  ", engine_bay_size)
				return(null)
			#Air Filter
			if block.lenght + air_filter.lenght + intake_manifold.lenght > max_lenght: #check so part doesn't fits in engine bay
				#print("air to large")
				return(null)
		#Other Engines
		else:
			#Exhaust Manifold
			if block.width * 0.5 + exhaust_manifold.width > max_width_r or block.lenght + exhaust_manifold.lenght > max_lenght: #check so part doesn't fits in engine bay
				#print("exhaust manifold to large")
				return(null)
			#Intake Manifold
			if block.width * 0.5 + intake_manifold.width > max_width_l or block.lenght + intake_manifold.lenght > max_lenght: #check so part doesn't fits in engine bay
				#print("intake manifold to large")
				return(null)
		
		#If engine is not within torque limits return NULL to generate new one
		if est_tq < torque * precision or est_tq > torque / precision:
			#print("Too much / too little torque:  ", est_tq, " ", torque)
			return null
		
		#If engine is not withing weight limits return NULL to generate new one
		var engine_weight = block.weight + exhaust_manifold.weight + intake_manifold.weight + internals.weight + air_filter.weight + top.weight
		if engine_weight < max_weight * (precision * 0.8) or engine_weight > max_weight / (precision * 0.8):
			#print("too heavy engine: ", engine_model, " ", exhaust_manifold, " ", weight, " ", engine_weight)
			return null
		
		#If engine is knocking return NULL to generate new one
		if boost_estimate_total > top.max_compression:
			#print("Too much boost / Compression:  ", boost_estimate_total)
			return null
		
		
		#print(" ")
		#print("SUCCESS")
		#print(" ")
		#If engine is within torque limits return engine
		return {"Engine_ID" : block.Engine_ID,
		"max_boost" : boost_estimate_turbo,
		"max_rpm" : top.max_hp_rpm * 1.2,
		"Tq" : est_tq,
		"block" : block.Part_Number,
		"intake_manifold" : intake_manifold.Part_Number,
		"exhaust_manifold" : exhaust_manifold.Part_Number,
		"internals" : internals.Part_Number,
		"top" : top.Part_Number,
		"air_filter" : air_filter.Part_Number,}
	
	else:
		return(null)


#Side functions used by main
func _find_suitable_part(category ,category_array, stat1_range, stat2_range, stat_import):  #Model is the Car or Engine model, Category is the type of part, Stat to check is the stat that we want
	var temp_array = []
	var temp_backup_array = []
	var max_rarity_offset = 1
	var stat_1
	var stat_2
	var instance
	#For loop for finding parts that fit the criterias
	for i in category_array.size() - 1:
		#Get correct stat
		match category:
			"driveshaft", "gearbox":
				instance = category_array[i+1].instantiate()
				stat_1 = instance.drivetrain
			"fenders":
				instance = category_array[i+1].instantiate()
				stat_2 = instance.max_tire_width * 5
			"wheels":
				instance = category_array[i+1].instantiate()
				stat_2 = instance.max_tire_width #Get aproximate grip capacity of rims
			"tires":
				instance = category_array[i+1].instantiate()
				stat_1 = instance.grip
				stat_2 = instance.width
			"spoiler", "f_bumper":
				instance = category_array[i+1].instantiate()
				stat_1 = instance.downforce
			"headlights", "taillights", "mirrors", "subframe", "exhaust", "suspension":
				instance = category_array[i+1].instantiate()
			"hood", "r_bumper":
				instance = category_array[i+1].instantiate()
				stat_1 = instance.weight
			"brakes":
				instance = category_array[i+1].instantiate()
				stat_1 = instance.brake_force
			"radiator":
				instance = category_array[i+1].instantiate()
			"block":
				instance = category_array[i+1].instantiate()
				stat_1 = instance.max_tq
			"intake_manifold":
				instance = category_array[i+1].instantiate()
				if instance.supercharger == true:
					stat_1 = stat_import * (instance.supercharer_displacement_capacity * 0.0004) #Estimate supercharger power
					stat_1 *= instance.tq_mod
				else:
					stat_1 = stat_import * instance.tq_mod
				stat_2 = instance.width
			"exhaust_manifold":
				instance = category_array[i+1].instantiate()
				if instance.turbo == true:
					#Estimate Boost Level
					var max_boost_estimate = _estimate_boost(stat_import[0], stat_import[2], stat_import[1], instance.get_turbo_max_size(), instance.turbo_efficiency)
					stat_1 = stat_import[0]
					stat_1 += stat_import[2] * (max_boost_estimate * (instance.get_turbo_max_size()/70)*instance.turbo_efficiency) #Estimate turbo power
					stat_1 *= instance.tq_mod
				else:
					stat_1 = stat_import[0] * instance.tq_mod
				if stat_import[3] == "top" and instance.turbo == true: #If carb and turbo make it illegal (by pretending to be huge so it won't fit)
					stat_2 = 9999
				else:
					stat_2 = instance.width
			"internals":
				instance = category_array[i+1].instantiate()
				stat_1 = instance.max_tq
				var stock_internals = category_array[1].instantiate()
				stat_2 = instance.compression + 2.5 - stock_internals.compression
			"top":
				instance = category_array[i+1].instantiate()
				var stock_top = category_array[1].instantiate()
				var rev_hp_boost = instance.max_hp_rpm / stock_top.max_hp_rpm
				stat_1 = stat_import + instance.tq_mod * rev_hp_boost
				stat_2 = instance.max_compression
			"air_filter":
				instance = category_array[i+1].instantiate()
				stat_2 = instance.layout
		
		if (stat1_range == null or stat_1 >= stat1_range[0] and stat_1 <= stat1_range[1]) and (stat2_range == null or stat_2 >= stat2_range[0] and stat_2 <= stat2_range[1]):
			temp_array.append(instance)
		elif (stat2_range == null or stat_2 >= stat2_range[0] and stat_2 <= stat2_range[1]):
			if (stat1_range == null or stat_1 * 1.5 >= stat1_range[0] and stat_1 * 0.5 <= stat1_range[1]):
				temp_backup_array.append(instance)
	var rng = randi_range(0, temp_array.size()-1)
	
	#Backup array to prevent crash
	if temp_array.size() == 0 and temp_backup_array.size() != 0:
		rng = randi_range(0, temp_backup_array.size()-1)
		#print("backup: ", temp_backup_array[rng])
		return(temp_backup_array[rng])
	
	#Backup 2 just equips stock part
	if temp_array.size() == 0:
		if category_array.size() > 1:
			return(category_array[1].instantiate())
		else:
			return(category_array[0].instantiate())
	
	return(temp_array[rng])

func _estimate_boost(tq_boost, tq, goal_tq, turbo_size, turbo_efficiency):
	var max_boost_estimate = 0
	var temp_max_boost = 0.0
	var temp_power = tq_boost
	#print(turbo_size/70)
	while max_boost_estimate == 0:
		temp_max_boost += 0.1
		temp_power = tq_boost
		temp_power += tq * (temp_max_boost * (turbo_size/70)*turbo_efficiency)
		if temp_power >= goal_tq or temp_max_boost >= 3:
			max_boost_estimate = temp_max_boost
			return max_boost_estimate
			break

func _generate_gear_ratio(gears, top_speed_estimate):
	pass
