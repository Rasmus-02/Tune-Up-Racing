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
@export var description_text : Label
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
	
	##Update the description
	description_text.text = get_description(dict.personality, car, hp, milage_modifier)


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


func get_description(personality, car, hp, durability):
	#variables that each personality needs
	var prompts : int #How many things they will talk about
	var description : String
	match personality:
		"positive":
			prompts = 4
			if prompts > 0 and car.weight < 1200:
				description += "A lightweight and fun to drive car, it is great around corners. "
				prompts -= 1
			if prompts > 0 and car.tires.grip > 800 and car.tires.grip < 1000 and car.tires.durability > 80:
				description += "The tires on the car are decent but nothing special. "
				prompts -= 1
			elif prompts > 0 and car.tires.grip > 1000 and car.tires.durability > 80:
				description += "A set of really great and grippy tires have recently been installed on the car. "
				prompts -= 1
			if prompts > 0 and car.downforce > 300:
				description += "If you need a car that is able to handle corners at high speeds around the track, this is the car for you. "
				prompts -= 1
			if prompts > 0 and hp < 100:
				description += "It might not have the best acceleration or top speed, but it has a lot of character. "
				prompts -= 1
			if prompts > 0 and hp > 250 and hp < 500:
				description += "The engine is wonderful, you can really feel how you get pushed back in the seat when stepping on the gas. "
				prompts -= 1
			if prompts > 0 and hp > 500:
				description += "You need to be careful when stepping on the gas, because the engine in this beast is really powerful. "
				prompts -= 1
			if prompts > 0 and car.engine.turbo == true and car.engine.supercharger == false:
				description += "The engine is also turbocharged, which is quite nice. "
				prompts -= 1
			if prompts > 0 and car.engine.turbo == false and car.engine.supercharger == true:
				description += "The engine is also supercharged, which is quite nice. "
				prompts -= 1
			if prompts > 0 and car.engine.turbo == true and car.engine.supercharger == true:
				description += "The engine in the car is quite unique, because it is twin-charged. "
				prompts -= 1
			if prompts > 0 and durability > 90:
				description += "Both the car and engine are in really great condition. "
				prompts -= 1
			if prompts > 0 and durability < 70:
				description += "The car is not in the best shape, however with some attention, this car could be a real gem. "
				prompts -= 1
		"negative":
			prompts = 4
			if prompts > 0 and car.weight < 1200:
				description += "The car weighs next to nothing, which is one of the reasons I'm selling the car, it just doesn't feel safe. "
				prompts -= 1
			if prompts > 0 and car.tires.grip > 800 and car.tires.grip < 1000 and car.tires.durability > 80:
				description += "The tires aren't all that great. "
				prompts -= 1
			elif prompts > 0 and car.tires.grip > 1000 and car.tires.durability > 80:
				description += "I guess the tires are pretty decent. "
				prompts -= 1
			if prompts > 0 and car.downforce > 300:
				description += "The stupid downforce on the car makes it horrible for fuel efficiency. "
				prompts -= 1
			if prompts > 0 and hp < 100:
				description += "It is really really slow, it takes ages for the stupid thing to get up to speed. "
				prompts -= 1
			if prompts > 0 and hp > 250 and hp < 500:
				description += "I guess the engine is decent, however it consumes quite a bit of fuel. "
				prompts -= 1
			if prompts > 0 and hp > 500:
				description += "The car feels way to scary when stepping on the gas thanks to its loud and obnoxious engine. "
				prompts -= 1
			if prompts > 0 and car.engine.turbo == true and car.engine.supercharger == false:
				description += "The engine is also turbocharged, which means you have to deal with turbo lag. "
				prompts -= 1
			if prompts > 0 and car.engine.turbo == false and car.engine.supercharger == true:
				description += "The engine is also supercharged, so you will have to deal with that annoying supercharger whine the whole time you are driving. "
				prompts -= 1
			if prompts > 0 and car.engine.turbo == true and car.engine.supercharger == true:
				description += "The engine in the car is kind of weird, because it has both a turbo and a supercharger. "
				prompts -= 1
			if prompts > 0 and durability > 90:
				description += "The car has been barely driven, so you won't have to worry about fixing it up all that much. "
				prompts -= 1
			if prompts > 0 and durability < 70:
				description += "The car is kind of a piece of crap, it needs a lot of work. "
				prompts -= 1
		"scammer":
			prompts = 4
			if prompts > 0 and car.weight < 1200:
				description += "The car is super lightweight, it handles like an F1 car. "
				prompts -= 1
			if prompts > 0 and car.tires.grip > 800 and car.tires.grip < 1000 and car.tires.durability > 80:
				description += "The tires might not be the most expensive, but who cares the car still handles super great. "
				prompts -= 1
			elif prompts > 0 and car.tires.grip > 1000 and car.tires.durability > 80:
				description += "Some of the best tires ever made are installed on this bad boy. "
				prompts -= 1
			if prompts > 0 and car.downforce > 300:
				description += "The downforce on this beast is insane. You can feel the suspension almost bottoming out around the corners. "
				prompts -= 1
			if prompts > 0 and hp < 100:
				description += "Honestly for such a small engine the car feels really fast! I beat a 1000cc bike the other day in it, NO JOKE! "
				prompts -= 1
			if prompts > 0 and hp > 250 and hp < 500:
				description += "This car feels scary fast, like just stepping on the throttle a little and you are just zooming past all the other cars on the highway. "
				prompts -= 1
			if prompts > 0 and hp > 500:
				description += "This engine is no joke, it is straight out of a race car! 0 - 100kmh in a couple of seconds, it's insane! "
				prompts -= 1
			if prompts > 0 and car.engine.turbo == true and car.engine.supercharger == false:
				description += "One of the coolest things about this car is that it has a turbo so you can just crank the boost up and the car will be super fast. "
				prompts -= 1
			if prompts > 0 and car.engine.turbo == false and car.engine.supercharger == true:
				description += "One of the coolest things about this car is that it is supercharged, which means you can easily beat most cars on the road in a drag race. "
				prompts -= 1
			if prompts > 0 and car.engine.turbo == true and car.engine.supercharger == true:
				description += "The engine has both a TURBO AND A SUPERCHARGER!! Which is crazy, because like you get the benefits of both with none of the downsides! "
				prompts -= 1
			if prompts > 0 and durability > 90:
				description += "The car is pretty much straight out of the factory, it is in pristine condition. "
				prompts -= 1
			if prompts > 0 and durability < 70:
				description += "It has a couple of scratches here and there, but honestly nothing that can't be polished out. "
				prompts -= 1
		"lazy":
			prompts = 2
			if prompts > 0 and car.weight < 1200:
				description += "Nice and lightweight car. "
				prompts -= 1
			if prompts > 0 and hp < 100:
				description += "Pretty slow. "
				prompts -= 1
			if prompts > 0 and hp > 250 and hp < 500:
				description += "Pretty fast. "
				prompts -= 1
			if prompts > 0 and hp > 500:
				description += "Really fast. "
				prompts -= 1
			if prompts > 0 and car.engine.turbo == true and car.engine.supercharger == true:
				description += "Twin-Charged. "
				prompts -= 1
			if prompts > 0 and durability > 90:
				description += "Good condition. No lowballers I know what I have! "
				prompts -= 1
			if prompts > 0 and durability < 70:
				description += "Needs work. No lowballers I know what I have! "
				prompts -= 1
		"smart":
			prompts = 5
			if prompts > 0 and car.weight < 1200:
				description += "A lightweight and great handling car. "
				prompts -= 1
			if prompts > 0 and car.tires.grip > 800 and car.tires.grip < 1000 and car.tires.durability > 80:
				description += "A pair of pretty decent " + car.tires.name + " have been installed. "
				prompts -= 1
			elif prompts > 0 and car.tires.grip > 1000 and car.tires.durability > 80:
				description += "A really nice set of " + car.tires.name + " have been installed. "
				prompts -= 1
			if prompts > 0 and car.downforce > 300:
				description += "Aero has been installed on the car to provide a nice amount downforce. "
				prompts -= 1
			if prompts > 0 and hp < 100:
				description += "Fuel economy is great, but it's a bit sluggish because of its weak engine. "
				prompts -= 1
			if prompts > 0 and hp > 250 and hp < 500:
				description += "A great engine under the bonnet in this one. "
				prompts -= 1
			if prompts > 0 and hp > 500:
				description += "The car's high-performance engine translates into exceptional top speed and acceleration. "
				prompts -= 1
			if prompts > 0 and car.engine.turbo == true and car.engine.supercharger == false:
				description += "The engine is also turbocharged, so it has great high end power. "
				prompts -= 1
			if prompts > 0 and car.engine.turbo == false and car.engine.supercharger == true:
				description += "The engine is also supercharged, so it has great low end power. "
				prompts -= 1
			if prompts > 0 and car.engine.turbo == true and car.engine.supercharger == true:
				description += "The engine utilizes a twin-charged system, combining the advantages of turbocharging and supercharging. "
				prompts -= 1
			if prompts > 0 and durability > 90:
				description += "The car and the engine is like new. "
				prompts -= 1
			if prompts > 0 and durability < 70:
				description += "The car could use some work, I am quite busy at the moment therefore I am selling it. Great project car! "
				prompts -= 1
		"idiot":
			prompts = 4
			if prompts > 0 and car.weight < 1200:
				description += "I read on Gooble.com that the car should be quite lightweight so I think that's pretty nice. "
				prompts -= 1
			if prompts > 0 and car.downforce > 300:
				description += "My dad told me that the car has some downforce thingy installed, so that's cool I guess. "
				prompts -= 1
			if prompts > 0 and hp < 100:
				description += "The car doesn't feel all that fast. But it sure beats walking everywhere. "
				prompts -= 1
			if prompts > 0 and hp > 250 and hp < 500:
				description += "The car feels really fast. Like it's way faster than my moms Nagata Koi. "
				prompts -= 1
			if prompts > 0 and hp > 500:
				description += "Honestly this car is scary fast, you have to be carefull when stepping on the throttle. "
				prompts -= 1
			if prompts > 0 and car.engine.turbo == true and car.engine.supercharger == false:
				description += "I think the car had some turbocharger thingy or was it a supercharger? I can't remember but that's pretty cool too. "
				prompts -= 1
			if prompts > 0 and car.engine.turbo == false and car.engine.supercharger == true:
				description += "I think the car had some turbocharger thingy or was it a supercharger? I can't remember but that's pretty cool too. "
				prompts -= 1
			if prompts > 0 and car.engine.turbo == true and car.engine.supercharger == true:
				description += "I think the car had both a supercharge thingy and a turbo, so that's cool. "
				prompts -= 1
			if prompts > 0 and durability > 90:
				description += "This car is like new. Don't try to lowball me I know what I have! "
				prompts -= 1
			if prompts > 0 and durability < 70:
				description += "The car started last winter, and I think it still should start. Don't try to lowball me I know what I have! "
				prompts -= 1
	
	return description


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
	car_node.delete_car()
	get_parent().close()
func _on_no_pressed():
	buy_popup.hide()



##CLEANER
func _ready():
	#Set script to "not pauseable"
	process_mode = Node.PROCESS_MODE_ALWAYS

# ORPHAN NODE HANDLER, DELETE WHEN SCENE CHANGE
func _init():
	Utils.connect("freeing_orphans", Callable(self, "_free_if_orphaned"))
func _free_if_orphaned():
	if not is_inside_tree(): # Optional check - don't free if in the scene tree
		for child in get_children():
			child.queue_free()
		queue_free()

