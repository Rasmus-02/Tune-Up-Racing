extends generator
var file_location = "user://car_market.save"
var car_list = {}
enum EVENT {ADD, REMOVE}
var event_queue = [] #ADD or REMOVE events to/from queue
var countdown : int = 0 #When reach 0 add or remove a car from car market
var market_size : int = 0

func _ready():
	#If file doesn't exist create new file
	if FileAccess.file_exists(file_location) == false:
		print("NEW CAR MARKET FILE CREATED")
		var file = FileAccess.open(file_location, FileAccess.WRITE)
		save()
	#Load the file
	load_file()

func _physics_process(_delta):
	if Input.is_action_just_pressed("Handbrake"):
		update_events()
		save()
	
	if countdown <= 0:
		generate_event()

#Add or remove a car from the market
func generate_event():
	#Make market fluxuate between 50 - 100 cars
	if car_list.size() >= 100:
		event_queue.append(EVENT.REMOVE)
		market_size -= 1
	elif car_list.size() <= 50:
		event_queue.append(EVENT.ADD)
		market_size += 1
	else:
		event_queue.append(randi_range(0,1)) #Queue up random event
	refresh_countdown()

#Generate new Countdown time
func refresh_countdown():
	var rng_time : int
	var min = 30
	var max = 120
	#This if else statement makes it so the car market is more busy during the day, and extra busy during the weekend
	if Clock.hour < 8 or Clock.hour >= 20: #If at night (double cooldown delay)
		min *= 2
		max *= 2
	if Clock.day >= 6: #If weekend make day cooldown 1/2 min --> 2 min
		min -= 15
		max -= 60
	
	rng_time = randi_range(min, max) #Seconds
	countdown = rng_time

#Empty event queue and add / remove all the cars that are queued upp 
func update_events():
	for event in event_queue:
		if event == EVENT.ADD:
			event_add()
		elif event == EVENT.REMOVE:
			event_remove()
	
	#Clear queue after finnished
	event_queue.clear()

func event_add():
	var car = null
	var engine = null
	var step = 0 #TESTING TOOL TO BENCHMARK PERFORMANCE
	var precision = 0.2
	#Generate a car that isn't null
	while car == null:
		step += 1
		
		#Generate requirements for the new car
		var rarity = (int(Save_Load.level)/10) #lvl10 = 1, lvl20 = 2 --- lvl29 = 2, lvl30 = 3 ...
		var weight = randi_range(500, 2500)
		var grip = randi_range(600, 2000)
		var downforce = randi_range(0, 250)
		var brake_force = randi_range(500, 2000)
		var tq = randf_range(100, 35 * Save_Load.level)
		
		if step > 5:
			precision -= 0.02
		precision = clamp(precision, 0.25, 0.8)
		car = generate_car(rarity, int(weight), tq, grip, downforce, brake_force, precision, false)
		if car != null:
			#Try 3 time to find an engine
			for i in 3:
				engine = generate_engine(rarity, weight, car.weight, tq, car.engine_bay_size, car.position_offset, car.drivetrain, car.stock_engine, precision, false)
				step += 1
				if engine != null:
					break
		
		#If can't find engine for car, reroll car
		if engine == null:
			car = null
		
		if car != null:
			break
	
	var max_rng = Colors.list.size() - 1 #-1 because start at index 0
	var random_color = randi_range(0, max_rng)
	var colors = {"chassi" : unpainted(random_color), "fenders" : unpainted(random_color), "f_bumper" : unpainted(random_color), 
	"r_bumper": unpainted(random_color), "hood" : unpainted(random_color), "headlights" : unpainted(random_color), 
	"taillights" : unpainted(random_color), "spoiler" : unpainted(random_color), "mirrors" : unpainted(random_color)}
	
	var engine_reliability = engine.reliability
	var car_reliability = engine.reliability
	var durability = {"chassi" : get_durability(car_reliability), "fenders" : get_durability(car_reliability), 
	"f_bumper" : get_durability(car_reliability), "r_bumper": get_durability(car_reliability), "hood" : get_durability(car_reliability),
	"headlights" : get_durability(car_reliability), "taillights" : get_durability(car_reliability), "spoiler" : get_durability(car_reliability), 
	"mirrors" : get_durability(car_reliability), "driveshaft" : get_durability(car_reliability), "exhaust" : get_durability(car_reliability), 
	"subframe" : get_durability(car_reliability), "block" : get_durability(engine_reliability), "internals" : get_durability(engine_reliability), 
	"top" : get_durability(engine_reliability), "intake_manifold" : get_durability(engine_reliability),
	"exhaust_manifold" : get_durability(engine_reliability), "air_filter" : get_durability(engine_reliability)}
	
	var car_price = car.price * ((durability.chassi + durability.fenders + durability.f_bumper + durability.r_bumper
	+ durability.hood + durability.spoiler + durability.driveshaft + durability.exhaust + durability.subframe) / 900.0)
	var engine_price = engine.price * ((durability.block + durability.internals + durability.top
	 + durability.intake_manifold + durability.exhaust_manifold) / 500.0)
	var price_rng = randf_range(1.1, 1.4) # Can get good deal but can also get scammed
	var price = int((car_price + engine_price) * price_rng)
	
	var temp = 0 #Find empty key in dict
	for n in car_list.keys().size():
		var sort_var = int(car_list.keys()[n])
		if sort_var > temp:
			temp = sort_var
		n+=1
	
	car_list[temp + 1] = {"car" : car, "engine" : engine, "colors": colors, "durability" : durability, 
	"key" : (temp + 1),"favorite_status" : false, "picture" : [0,0], "price" : price, "photo_settings" : generate_camera_views()}
	save()

func event_remove():
	var size = car_list.size()
	var random_key = car_list.keys()[randi() % size]
	car_list.erase(random_key)

#Calculate chanse that panel is unpainted
func unpainted(color):
	var unpainted_chanse = randi_range(0,10)
	if unpainted_chanse == 10: #10%
		return 0
	else:
		return color

func get_durability(reliability):
	#Reliability reduces risk of bein damaged and increases min durability value
	var random_durability = randi_range(0, (300 * reliability))
	random_durability = clamp(random_durability, (25 * reliability), 100) #Make it so only 30% risk that damaged
	return random_durability

func generate_camera_views():
	
	var camera_settings = {"full_body" : {"position" : [148, 152], "zoom" : 1, "rotation" : 0, "filter" : 0, "scene" : 0},
	"hood_view" : {"position" : [218, 152], "zoom" : 2.5, "rotation" : 0, "filter" : 0, "scene" : 0},
	"rear_view" : {"position" : [85, 152], "zoom" : 2, "rotation" : 225, "filter" : 0, "scene" : 0},
	"front_view" : {"position" : [212, 152], "zoom" : 2, "rotation" : 225, "filter" : 0, "scene" : 0},
	"tilted_full" : {"position" : [148, 152], "zoom" : 1, "rotation" : 20, "filter" : 0, "scene" : 0},
	"tilted_hood" : {"position" : [210, 152], "zoom" : 2.5, "rotation" : 20, "filter" : 0, "scene" : 0},
	"tilted_down_full" : {"position" : [142, 152], "zoom" : 1, "rotation" : 315, "filter" : 0, "scene" : 0},
	"zoomed_downwards" : {"position" : [205, 152], "zoom" : 2, "rotation" : 270, "filter" : 0, "scene" : 0},
	"messy_tilt" : {"position" : [148, 152], "zoom" : 0.8, "rotation" : 190, "filter" : 0, "scene" : 0},
	"messy_tilt2" : {"position" : [148, 152], "zoom" : 0.75, "rotation" : 20, "filter" : 0, "scene" : 0},
	"45_tilt" : {"position" : [148, 152], "zoom" : 1.3, "rotation" : 45, "filter" : 0, "scene" : 0},
	"20_tilt_rear" : {"position" : [64, 152], "zoom" : 2.3, "rotation" : 20, "filter" : 0, "scene" : 0}}
	
	var random_photo_setup = {}
	var random_filter = randi_range(0, 15)
	var random_scene = 0
	if random_filter >= 2:
		random_filter = 999
	for i in 4:
		var size = camera_settings.size()
		var key = camera_settings.keys()[randi() % size]
		random_photo_setup[i] = camera_settings[key]
		random_photo_setup[i].filter = random_filter
		random_photo_setup[i].scene = randi_range(0, 9)
		camera_settings.erase(key) #Remove so no same pictures
	
	return random_photo_setup


func save():
	if FileAccess.file_exists(file_location):
		var save_dict = {"cars" : car_list, "event_queue" : event_queue, "countdown" : countdown, "market_size" : market_size}
		var save_game = FileAccess.open(file_location, FileAccess.WRITE)
		var json_string = JSON.stringify(save_dict)
		save_game.store_line(json_string)

func load_file():
	if FileAccess.file_exists(file_location):
		var dataFile = FileAccess.open(file_location, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		if parsedResult != null:
			car_list = parsedResult.cars
			event_queue = parsedResult.event_queue
			countdown = parsedResult.countdown
			market_size = parsedResult.cars.size()
		else:
			print("FAULTY CAR MARKET DIRECTORY")
