extends Node

#Cars
@export_category("Cars")
@export var car_list : Node #List of all cars

#Engines
@export_category("Engines")
@export var engine_list : Node #List of all engines


var part_list = [] #List where all the parts meeting the filters will go
func get_parts(category, rarity, id, search_word, save_or_not): #Can sort by category, engine/car or all, specific engine or car (id) and limit max rarity
	#savefile_to_part()
	part_list.clear()
	#Order of these parts affect how they are shown in lists such as shops
	#CAR
	if category == "Front Bumper" or category == "all" or category == "car":
		if id == null:
			for car in car_list.get_child_count()-1:
				var temp_array = car_list.get_child(car+1).f_bumper
				iterate_array(temp_array, rarity, search_word, save_or_not)
		else:
			var temp_array = car_list.get_child(id+1).f_bumper
			iterate_array(temp_array, rarity, search_word, save_or_not)
	if category == "Rear Bumper" or category == "all" or category == "car":
		if id == null:
			for car in car_list.get_child_count()-1:
				var temp_array = car_list.get_child(car+1).r_bumper
				iterate_array(temp_array, rarity, search_word, save_or_not)
		else:
			var temp_array = car_list.get_child(id+1).r_bumper
			iterate_array(temp_array, rarity, search_word, save_or_not)
	if category == "Fenders" or category == "all" or category == "car":
		if id == null:
			for car in car_list.get_child_count()-1:
				var temp_array = car_list.get_child(car+1).fenders
				iterate_array(temp_array, rarity, search_word, save_or_not)
		else:
			var temp_array = car_list.get_child(id+1).fenders
			iterate_array(temp_array, rarity, search_word, save_or_not)
	if category == "Hood" or category == "all" or category == "car":
		if id == null:
			for car in car_list.get_child_count()-1:
				var temp_array = car_list.get_child(car+1).hood
				iterate_array(temp_array, rarity, search_word, save_or_not)
		else:
			var temp_array = car_list.get_child(id+1).hood
			iterate_array(temp_array, rarity, search_word, save_or_not)
	if category == "Mirrors" or category == "all" or category == "car":
		if id == null:
			for car in car_list.get_child_count()-1:
				var temp_array = car_list.get_child(car+1).mirrors
				iterate_array(temp_array, rarity, search_word, save_or_not)
		else:
			var temp_array = car_list.get_child(id+1).mirrors
			iterate_array(temp_array, rarity, search_word, save_or_not)
	if category == "Headlights" or category == "all" or category == "car":
		if id == null:
			for car in car_list.get_child_count()-1:
				var temp_array = car_list.get_child(car+1).headlights
				iterate_array(temp_array, rarity, search_word, save_or_not)
		else:
			var temp_array = car_list.get_child(id+1).headlights
			iterate_array(temp_array, rarity, search_word, save_or_not)
	if category == "Taillights" or category == "all" or category == "car":
		if id == null:
			for car in car_list.get_child_count()-1:
				var temp_array = car_list.get_child(car+1).taillights
				iterate_array(temp_array, rarity, search_word, save_or_not)
		else:
			var temp_array = car_list.get_child(id+1).taillights
			iterate_array(temp_array, rarity, search_word, save_or_not)
	if category == "Spoiler" or category == "all" or category == "car":
		if id == null:
			for car in car_list.get_child_count()-1:
				var temp_array = car_list.get_child(car+1).spoiler
				iterate_array(temp_array, rarity, search_word, save_or_not)
		else:
			var temp_array = car_list.get_child(id+1).spoiler
			iterate_array(temp_array, rarity, search_word, save_or_not)
	if category == "Suspension" or category == "all" or category == "car":
		var temp_array = car_list.get_child(0).suspension
		iterate_array(temp_array, rarity, search_word, save_or_not)
	if category == "Wheels" or category == "all" or category == "car":
		var temp_array = car_list.get_child(0).wheels
		iterate_array(temp_array, rarity, search_word, save_or_not)
	if category == "Tires" or category == "all" or category == "car":
		var temp_array = car_list.get_child(0).tires
		iterate_array(temp_array, rarity, search_word, save_or_not)
	if category == "Brakes" or category == "all" or category == "car":
		var temp_array = car_list.get_child(0).brakes
		iterate_array(temp_array, rarity, search_word, save_or_not)
	if category == "Subframe" or category == "all" or category == "car":
		if id == null:
			for car in car_list.get_child_count()-1:
				var temp_array = car_list.get_child(car+1).subframe
				iterate_array(temp_array, rarity, search_word, save_or_not)
		else:
			var temp_array = car_list.get_child(id+1).subframe
			iterate_array(temp_array, rarity, search_word, save_or_not)
	if category == "Driveshaft" or category == "all" or category == "car":
		if id == null:
			for car in car_list.get_child_count()-1:
				var temp_array = car_list.get_child(car+1).driveshaft
				iterate_array(temp_array, rarity, search_word, save_or_not)
		else:
			var temp_array = car_list.get_child(id+1).driveshaft
			iterate_array(temp_array, rarity, search_word, save_or_not)
	if category == "Gearbox" or category == "all" or category == "car":
		var temp_array = car_list.get_child(0).gearbox
		iterate_array(temp_array, rarity, search_word, save_or_not)
	if category == "Radiator" or category == "all" or category == "car":
		var temp_array = car_list.get_child(0).radiator
		iterate_array(temp_array, rarity, search_word, save_or_not)
	if category == "Exhaust" or category == "all" or category == "car":
		if id == null:
			for car in car_list.get_child_count()-1:
				var temp_array = car_list.get_child(car+1).exhaust
				iterate_array(temp_array, rarity, search_word, save_or_not)
		else:
			var temp_array = car_list.get_child(id+1).exhaust
			iterate_array(temp_array, rarity, search_word, save_or_not)


	#Engine
	if category == "Block" or category == "all" or category == "engine":
		if id == null:
			for engine in engine_list.get_child_count()-1:
				var temp_array = engine_list.get_child(engine+1).block
				iterate_array(temp_array, rarity, search_word, save_or_not)
		else:
			var temp_array = engine_list.get_child(id).block
			iterate_array(temp_array, rarity, search_word, save_or_not)
	if category == "Internals" or category == "all" or category == "engine":
		if id == null:
			for engine in engine_list.get_child_count()-1:
				var temp_array = engine_list.get_child(engine+1).internals
				iterate_array(temp_array, rarity, search_word, save_or_not)
		else:
			var temp_array = engine_list.get_child(id).internals
			iterate_array(temp_array, rarity, search_word, save_or_not)
	if category == "Top" or category == "all" or category == "engine":
		if id == null:
			for engine in engine_list.get_child_count()-1:
				var temp_array = engine_list.get_child(engine+1).top
				iterate_array(temp_array, rarity, search_word, save_or_not)
		else:
			var temp_array = engine_list.get_child(id).top
			iterate_array(temp_array, rarity, search_word, save_or_not)
	if category == "Exhaust Manifold" or category == "all" or category == "engine":
		if id == null:
			for engine in engine_list.get_child_count()-1:
				var temp_array = engine_list.get_child(engine+1).exhaust_manifold
				iterate_array(temp_array, rarity, search_word, save_or_not)
		else:
			var temp_array = engine_list.get_child(id).exhaust_manifold
			iterate_array(temp_array, rarity, search_word, save_or_not)
	if category == "Intake Manifold" or category == "all" or category == "engine":
		if id == null:
			for engine in engine_list.get_child_count()-1:
				var temp_array = engine_list.get_child(engine+1).intake_manifold
				iterate_array(temp_array, rarity, search_word, save_or_not)
		else:
			var temp_array = engine_list.get_child(id).intake_manifold
			iterate_array(temp_array, rarity, search_word, save_or_not)
	if category == "Airfilter" or category == "all" or category == "engine":
		var temp_array = engine_list.get_child(0).air_filter
		iterate_array(temp_array, rarity, search_word, save_or_not)
	return(part_list)


func iterate_array(temp_array, rarity, search_word, save_or_not):
	for i in temp_array.size() -1:
					var temp_part = temp_array[i+1].instantiate()
					#If part is in range of rarity that is unlocked and search_word for shop is included
					#Save or not will is a way to detect if we want to check if item is in inventory
					if rarity_to_int(temp_part.rarity) <= rarity and (temp_part.name.to_lower().contains(search_word.to_lower()) or search_word == ""):
						if save_or_not == "Save":
							var item_array = Save_Load.inv_check(temp_part)
							if item_array.size() != 0: #If item is saved in inventory (also check how many of that item)
								var index = 0
								for stats in item_array: #For loop to add many of same item if there are more than 1, otherwise loop ends with 1
									if index > 0: #If multiples (to not overwrite durability)
										temp_part = temp_array[i+1].instantiate()
									temp_part.durability = stats[0]
									temp_part.color = stats[1]
									part_list.append(temp_part)
									index += 1
						else:
							part_list.append(temp_part)
					else:
						temp_part.queue_free()

func rarity_to_int(rarity):
	match rarity:
		"common":
			return 0
		"uncommon":
			return 1
		"rare":
			return 2
		"epic":
			return 3
		"legendary":
			return 4
