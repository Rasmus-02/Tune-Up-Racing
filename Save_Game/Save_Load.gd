extends Node2D

var engine = null
var car = null
var engines = {}
var cars = {}
var part_inventory = {}
var file_location = "user://savegame.save"
var temp_key = null
var temp_key_car = null
var temp_key_part = null
var selected_car_key = null

var startup_save = preload("res://Save_Game/startup_save.tscn")

func set_engine(NODE):
	engine = NODE
func set_car(NODE):
	car = NODE


func _ready():
	pass
	if load_file("engines") != null:
		engines = load_file("engines")
		print("engine list loaded")
	if load_file("cars") != null:
		cars = load_file("cars")
		print("car list loaded")
	if load_file("part_inventory") != null:
		part_inventory = load_file("part_inventory")
		print("part_inventory loaded")
	if load_file("selected_car_key") != null:
		selected_car_key = load_file("selected_car_key")
	
	#IF SAVEFILE IS EMPTY
	if FileAccess.file_exists(file_location) == false:
		var startup_save_instanse = startup_save.instantiate()
		var file = FileAccess.open(file_location, FileAccess.WRITE)
		if file:
			# Write the JSON string to the file
			file.store_string(JSON.stringify(startup_save_instanse.save))
			file.close()
			print("NEW SAVEFILE CREATED")
			_ready()


func save_engine_stats():
	if engine != null:
		var part_dict = {
			"name" : engine.get_child(0).get_child(0).name,
			"engine_id" : engine.selected_engine,
			"key" : temp_key,
			"size" : [engine.width_left, engine.width_right, engine.lenght_front, engine.lenght_rear],
			"block" : [engine.selected_block, engine.block_durability],
			"internals" : [engine.selected_internals, engine.internals_durability],
			"top" : [engine.selected_top, engine.top_durability],
			"exhaust_manifold" : [engine.selected_exhaust_manifold, engine.exhaust_manifold_durability],
			"intake_manifold" : [engine.selected_intake_manifold, engine.intake_manifold_durability],
			"air_filter" : [engine.selected_air_filter, engine.air_filter_durability],
			"tune" : [engine.max_boost, engine.max_rpm],
			"in_car": engine.in_car,
			"rarity": engine.rarity
		}
		return part_dict
func save_car_stats():
	if car != null:
		var part_dict = {
			"key" : temp_key_car,
			"engine" : car.selected_engine,
			"name" : car.get_child(0).get_child(0).name,
			"car_id" : car.selected_car,
			"chassi" : [car.selected_chassi, car.chassi_durability],
			"driveshaft" : [car.selected_driveshaft, car.driveshaft_durability],
			"subframe" : [car.selected_subframe, car.subframe_durability],
			"fenders" : [car.selected_fenders, car.fenders_durability],
			"f_bumper" : [car.selected_f_bumper, car.f_bumper_durability],
			"r_bumper" : [car.selected_r_bumper, car.r_bumper_durability],
			"hood" : [car.selected_hood, car.hood_durability],
			"headlights" : [car.selected_headlights, car.headlights_durability],
			"taillights" : [car.selected_taillights, car.taillights_durability],
			"spoiler": [car.selected_spoiler, car.spoiler_durability],
			"mirrors" : [car.selected_mirrors, car.mirrors_durability],
			"brakes" : [car.selected_brakes, car.brakes_durability],
			"suspension" : [car.selected_suspension, car.suspension_durability],
			"tires" : [car.selected_tires, car.tires_durability],
			"wheels" : [car.selected_wheels, car.wheels_durability],
			"gearbox" : [car.selected_gearbox, car.gearbox_durability],
			"radiator" : [car.selected_radiator, car.radiator_durability],
			"exhaust" : [car.selected_exhaust, car.exhaust_durability],
			"color" : Color(car.selected_color),
			"in_garage" : car.in_garage,
			"gear_ratio" : car.gear_ratio
		}
		return part_dict

func save_selected_key(key):
	selected_car_key = key
	return selected_car_key

func save():
	if FileAccess.file_exists(file_location):
		var save_dict = {"engines" : engines, "engine parts" : save_engine_stats(), "cars" : cars, "car parts" : save_car_stats(),"part_inventory" : part_inventory, "selected_car_key" : save_selected_key(selected_car_key)}
		var save_game = FileAccess.open(file_location, FileAccess.WRITE)
		var json_string = JSON.stringify(save_dict)
		save_game.store_line(json_string)
	else:
		"NULL SAVE"

func add_engine(): #for adding engines to the players inventory
	#adds a engine to the dictionary
	var i = 0
	if engines != null:
		i = largest_key("engine") + 1 #+1 to set the next engine
		temp_key = i
	engines[i] = save_engine_stats()
	save() #saves the engine to a JSON file
func add_car(): #for adding cars to the players inventory
	#adds a car to the dictionary
	var i = 0
	if cars != null:
		i = largest_key("car") + 1 #+1 to set the next car
		temp_key_car = i
	cars[i] = save_car_stats()
	save()#saves the car to a JSON file
func inv_add(item_to_add): #for adding parts to the players inventory (works differently from car and engine)
	#adds a part to the dictionary 
	#(part format [0 = Type(0 = Car 1 = Engine), 1 = ID (what car or engine it is for), 
	#2 = Part type (what type of part it is), 3 = Part number (what part in specific it is), 
	#4 = the key it has, 5 = durability)
	#{Type, ID, Part_Type, Part_number, Key, Durablility} 
	var i = 0
	if part_inventory != null:
		i = largest_key("part_inventory") + 1 #+1 to set the next car
	else:
		i = 0
	temp_key_part = i
	item_to_add.Key = temp_key_part
	part_inventory[i] = item_to_add #adds one item
	save() #saves the car to a JSON fil

func remove_engine(INDEX):
	engines = load_file("engines")
	engines.erase(str(INDEX))
	save()
func remove_car(INDEX):
	cars = load_file("cars")
	cars.erase(str(INDEX))
	save()
func remove_inv(INDEX):
	part_inventory = load_file("part_inventory")
	part_inventory.erase(str(INDEX))
	save()

func largest_key(category):
	var type = null
	if category == "car":
		type = cars
	elif category == "engine":
		type = engines
	elif category == "part_inventory":
		type = part_inventory
	#For loop for finding the biggest key
	var temp = 0
	for n in type.keys().size():
		var sort_var = int(type.keys()[n])
		if sort_var > temp:
			temp = sort_var
		n+=1
	return temp

func inv_check(part_to_be_checked): #checks if a part exists in the inventory
	var type = part_to_be_checked.type
	var part_type = part_to_be_checked.id[1]
	var part_number = part_to_be_checked.Part_Number
	var id = 402
	#print(part_to_be_checked)
	if type == 1:
		id = part_to_be_checked.Engine_ID
	elif type == 0:
		id = part_to_be_checked.Car_ID
	
	var size = part_inventory.size()
	var durability = 0
	var n = 0
	var i = 0
	var results = []
	while i < size:
		if part_inventory.get(str(n)) != null:
			i+=1
			var inv_part = part_inventory.get(str(n))
			if inv_part.Type == type and inv_part.Part_Type == part_type and inv_part.Part_number == part_number and inv_part.ID == id:
				durability = inv_part.Durability
				results.append(durability)
		n += 1
	return results

 
func edit_engine(engine_node): #For editing an engine in the dictionary
	set_engine(engine_node)
	engines = load_file("engines")
	if engines != null:
		engines[str(engine.selected_engine_key)] = save_engine_stats()
	else:
		engines = save_engine_stats()
	save()
func edit_car(car_node): #For editing a car in the dictionary
	set_car(car_node)
	cars = load_file("cars")
	if cars != null:
		cars[str(car.selected_car_key)] = save_car_stats()
	else:
		cars = save_car_stats()
	save()

func load_file(filetype):
	if FileAccess.file_exists(file_location):
		var dataFile = FileAccess.open(file_location, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		
		if parsedResult is Dictionary:
			#for selecting what index from the dictionary in the save file we want the stats from
			if filetype == "engines":
				engines = parsedResult.get("engines")
				return parsedResult.get("engines")
			elif filetype == "engine parts":
				return parsedResult.get("engine parts")
			elif filetype == "cars":
				return parsedResult.get("cars")
			elif filetype == "car parts":
				return parsedResult.get("car parts")
			elif filetype == "part_inventory":
				return parsedResult.get("part_inventory")
			elif filetype == "selected_car_key":
				return parsedResult.get("selected_car_key")
			elif filetype == "all":
				return parsedResult
		else:
			print("Error reading file")
	else:
		print("No savefile found")


func select_car(KEY):
	var sc = load_file("cars").get(str(KEY)) #selected car
	var part_dict = {
		"key" : sc.key,
		"engine" : sc.engine,
		"name" : sc.name,
		"car_id" : sc.car_id,
		"chassi" : [sc.chassi[0],sc.chassi[1]],
		"driveshaft" : [sc.driveshaft[0],sc.driveshaft[1]],
		"subframe" : [sc.subframe[0],sc.subframe[1]],
		"fenders" : [sc.fenders[0],sc.fenders[1]],
		"f_bumper" : [sc.f_bumper[0],sc.f_bumper[1]],
		"r_bumper" : [sc.r_bumper[0],sc.r_bumper[1]],
		"hood" : [sc.hood[0],sc.hood[1]],
		"headlights" : [sc.headlights[0],sc.headlights[1]],
		"taillights" : [sc.taillights[0],sc.taillights[1]],
		"spoiler": [sc.spoiler[0],sc.spoiler[1]],
		"mirrors" : [sc.mirrors[0],sc.mirrors[1]],
		"brakes" : [sc.brakes[0],sc.brakes[1]],
		"suspension" : [sc.suspension[0],sc.suspension[1]],
		"tires" : [sc.tires[0],sc.tires[1]],
		"wheels" : [sc.wheels[0],sc.wheels[1]],
		"gearbox" : [sc.gearbox[0], sc.gearbox[1]],
		"radiator" : [sc.radiator[0], sc.radiator[1]],
		"exhaust" : [sc.exhaust[0], sc.exhaust[1]],
		"color" : sc.color,
		"in_garage" : sc.in_garage,
		"gear_ratio" : sc.gear_ratio
	}
	return part_dict

func engine_key():
	var engine_index = 0
	if temp_key_car != null:
		engine_index = select_car(temp_key_car).engine
	return engine_index

func select_engine(KEY):
	var sc = load_file("engines").get(str(KEY)) #selected car
	var part_dict = {
		"name" : sc.name,
		"engine_id" : sc.engine_id,
		"key" : sc.key,
		"size" : sc.size,
		"block" : [sc.block[0], sc.block[1]],
		"internals" : [sc.internals[0], sc.internals[1]],
		"top" : [sc.top[0], sc.top[1]],
		"exhaust_manifold" : [sc.exhaust_manifold[0], sc.exhaust_manifold[1]],
		"intake_manifold" : [sc.intake_manifold[0], sc.intake_manifold[1]],
		"air_filter" : [sc.air_filter[0], sc.air_filter[1]],
		"tune" : [sc.tune[0], sc.tune[1]],
		"in_car": sc.in_car,
		"rarity": sc.rarity
	}
	return part_dict
