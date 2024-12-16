extends Control
@export var car_name : Label
@export var engine_name : Label
@export var car_stats : Label
@export var price : Label
@export var favorited : TextureButton
@export var car_display : Node2D
var car_dict = null

func update(car : CharacterBody2D, favorited_status : bool, picture_info : Array, price_info : int):
	# Check if car is favorited, if favorited highlight favorite icon
	favorited.button_pressed = favorited_status
	# Update the displayed stats
	car_name.text = car.get_node("Car_spawner").get_child(0).name
	engine_name.text = car.engine.get_node("Engine_spawner").get_child(0).name
	price.text = format_number(price_info)+"$"
	# Get all the relevant stats from car, after that add them upp into one neat string
	var fuel_type = car.fuel_type
	var gearbox_type = car.gearbox.gearbox_type
	var drivetrain_type = car.drive_train_type #0=RWD, 1=FWD, 2=AWD
	match drivetrain_type:
		0:
			drivetrain_type = "RWD"
		1:
			drivetrain_type = "FWD"
		2:
			drivetrain_type = "AWD"
	var roadworthy = "Not Functional"
	if car.is_functional() and car.engine.is_functional():
		roadworthy = "Functional"
	car_stats.text = fuel_type + " | " + gearbox_type + " | " + drivetrain_type + " | " + roadworthy

func load_car(dict):
	car_dict = dict
	var car = dict.car
	var engine = dict.engine
	var car_node = car_display.get_node("Car")
	car_node.load_car_from_algorithm(car)
	car_node.engine.load_car_from_algorithm(engine)
	#Paint
	car_node.chassi_color = dict.colors.chassi
	car_node.fenders_color = dict.colors.fenders
	car_node.f_bumper_color = dict.colors.f_bumper
	car_node.r_bumper_color = dict.colors.f_bumper
	car_node.hood_color = dict.colors.hood
	car_node.headlights_color = dict.colors.headlights
	car_node.taillights_color = dict.colors.taillights
	car_node.spoiler_color = dict.colors.spoiler
	car_node.mirrors_color = dict.colors.mirrors
	car_node.update_car_parts()
	update(car_node, dict.favorite_status, [0,0], car.price)

func format_number(num: int) -> String:
	var num_str = str(num)
	var result = ""
	var count = 0
	
	for i in range(num_str.length() - 1, -1, -1):
		result = num_str[i] + result
		count += 1
		if count % 3 == 0 and i != 0:
			result = "." + result  # Insert period as thousand separator
	
	return result


func _on_favorite_pressed():
	if car_dict != null:
		if car_dict.favorite_status == false:
			car_dict.favorite_status = true
		else:
			car_dict.favorite_status = false
		
		CarMarket.car_list[str(car_dict.key)] = car_dict
		CarMarket.save()

func _on_selector_pressed():
	print(get_parent().get_parent().get_parent().get_node("Car Detailed").open(car_dict))
