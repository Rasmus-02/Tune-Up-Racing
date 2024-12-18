extends Panel
@export var images : Panel
@export var car_name : Label
@export var engine_name : Label
@export var car_stats : Label
@export var price : Label
@export var favorited : TextureButton
@export var car_rarity : Sprite2D
@export var engine_rarity : Sprite2D
@export var milage : Label
@export var power : Label
@export var weight : Label
@export var buy_popup : Control
var dict : Dictionary
var car_node

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if buy_popup.visible == false:
			get_parent().close()
		else:
			buy_popup.hide()

func open(import_dict):
	dict = import_dict
	populate_view()
	#if player doesn't have enough money to buy the car, disable buy button
	if Save_Load.money < dict.car.price:
		$Buy.disabled = true

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
	car_rarity.modulate = FontColorSettings.get_color(car.get_node("Car_spawner").current_car[2])
	engine_rarity.modulate = FontColorSettings.get_color(car.engine.rarity)
	
	##Info Unique to detailed view
	var durability = dict.durability
	#Milage
	var milage_modifier = 0
	for part in durability.keys():
		milage_modifier += int(durability.get(part))
	milage_modifier = float(milage_modifier) / float(durability.size() * 100)
	var milage_value = format_number(int(1500000 - 1500000 * milage_modifier)) #0 durability = 1.500.000km, 0.8 durability = 300.000km
	milage.text = "Milage: " + milage_value + "km"
	
	#Estimated Power
	var engine_dyno_test = car.engine.estimate_torque()
	print(car.exhaust_tq_mod)
	var tq = int(engine_dyno_test.tq * (1 - car.drivetrain_loss) * car.exhaust_tq_mod)
	var hp = int(engine_dyno_test.hp * (1 - car.drivetrain_loss) * car.exhaust_tq_mod)
	power.text = "Power: " + str(hp) + "hp / " + str(tq) + "nm"
	
	#Update Weight
	weight.text = "Weight: " + str(car.weight) + "kg"
	

func populate_view():
	for i in images.get_child_count():
		var car_display = images.get_child(i).get_child(0).get_child(0)
		
		#Same code as in Used_Car_Shop_Car_Item
		var car = dict.car
		var engine = dict.engine
		var photo = dict.photo_settings
		car_node = car_display.get_node("Car")
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
		
		#Change the picture background
		var bg = car_display.get_node("Background")
		var filter = car_display.get_node("Filters")
		var camera = car_display.get_node("View")
		if i > 1: # For small screens that are selectable
			bg.get_child(photo.get(str(i-1)).scene).show()
			camera.zoom = Vector2(photo.get(str(i-1)).zoom, photo.get(str(i-1)).zoom)
			camera.position.x = photo.get(str(i-1)).position[0]
			camera.position.y = photo.get(str(i-1)).position[1]
			camera.rotation = rad_to_deg(photo.get(str(i-1)).rotation)
		else: #For main large display scene
			bg.get_child(photo.get(str(0)).scene).show()
			bg.get_child(photo.get(str(0)).scene).show()
			camera.zoom = Vector2(photo.get(str(0)).zoom, photo.get(str(0)).zoom)
			camera.position.x = photo.get(str(0)).position[0]
			camera.position.y = photo.get(str(0)).position[1]
			camera.rotation = rad_to_deg(photo.get(str(0)).rotation)
		
		if photo.get(str(0)).filter != 999: #IF filter is selected show (999 is null) and every photo has same filter
			filter.get_child(photo.get(str(0)).filter).show()
		
		update(car_node, dict.favorite_status, [0,0], car.price)

func change_view_image(index):
		var car_display = images.get_child(0).get_child(0).get_child(0)
		var photo = dict.photo_settings
		var bg = car_display.get_node("Background")
		var camera = car_display.get_node("View")
		#Disable background
		for background in bg.get_children():
			background.hide()
		#Enable new background
		bg.get_child(photo.get(str(index)).scene).show()
		bg.get_child(photo.get(str(index)).scene).show()
		camera.zoom = Vector2(photo.get(str(index)).zoom, photo.get(str(index)).zoom)
		camera.position.x = photo.get(str(index)).position[0]
		camera.position.y = photo.get(str(index)).position[1]
		camera.rotation = rad_to_deg(photo.get(str(index)).rotation)

func _on_button_1_pressed():
	change_view_image(0)
	
	deselect()
	$Button1.button_pressed = true

func _on_button_2_pressed():
	change_view_image(1)
	
	deselect()
	$Button2.button_pressed = true

func _on_button_3_pressed():
	change_view_image(2)
	
	deselect()
	$Button3.button_pressed = true

func _on_button_4_pressed():
	change_view_image(3)
	
	deselect()
	$Button4.button_pressed = true

func deselect():
	$Button1.button_pressed = false
	$Button2.button_pressed = false
	$Button3.button_pressed = false
	$Button4.button_pressed = false

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
	if dict != null:
		if dict.favorite_status == false:
			dict.favorite_status = true
		else:
			dict.favorite_status = false
		
		CarMarket.car_list[str(dict.key)] = dict
		CarMarket.save()


## BUY BUTTON
	
#Show buy popup view
func _on_buy_pressed():
	#If player can afford it
	if Save_Load.money >= dict.car.price:
		buy_popup.show()

#In buy popup view
func _on_yes_pressed():
	buy_popup.buy_car(car_node, dict.car.price)
	CarMarket.car_list.erase(str(dict.key))
	CarMarket.save()
	get_parent().close()
func _on_no_pressed():
	buy_popup.hide()




