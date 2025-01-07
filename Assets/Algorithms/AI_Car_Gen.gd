extends generator


var player : CharacterBody2D
var loaded = false
func _ready():
	player = get_parent().get_node("Player").get_child(0)

func _process(delta):
	if loaded == false and player.loaded == true:
		for i in get_child_count():
			var car = get_ai_car().car
			var engine = get_ai_car().engine
			#Select a color from the color list
			var max_rng = Colors.list.size() - 1 #-1 because start at index 0
			var rng = randi_range(0, max_rng)
			#Load in the car and engine
			get_child(i).load_car_from_algorithm(car)
			get_child(i).engine.load_car_from_algorithm(engine)
			#Paint
			get_child(i).chassi_color = rng
			get_child(i).fenders_color = rng
			get_child(i).f_bumper_color = rng
			get_child(i).r_bumper_color = rng
			get_child(i).hood_color = rng
			get_child(i).headlights_color = rng
			get_child(i).taillights_color = rng
			get_child(i).spoiler_color = rng
			get_child(i).mirrors_color = rng
			get_child(i).update_car_parts()
		
		loaded = true


func get_ai_car():
	var rarity = player.get_child(0).current_car[2]
	var weight = player.weight
	var grip = player.max_tire_limit
	var downforce = player.downforce
	var brake_force = player.brake_force
	var tq = player.engine.estimate_torque().tq
	var car = null
	var engine = null
	var step = 0 #TESTING TOOL TO BENCHMARK PERFORMANCE
	var precision = 0.8
	#Generate a car that isn't null
	while car == null:
		step += 1
		if step > 5:
			precision -= 0.02
		precision = clamp(precision, 0.25, 0.8)
		car = generate_car(rarity, weight, tq, grip, downforce, brake_force, precision, true)
		
		#Try 3 time to find an engine
		for i in 3:
			engine = generate_engine(rarity, weight, car.weight, tq, car.engine_bay_size, car.position_offset, car.drivetrain, car.stock_engine, precision, true)
			step += 1
			if engine != null:
				break
		
		#If can't find engine for car, reroll car
		if engine == null:
			car = null
		
		if car != null:
			break
	
	return {"car" : car,
	"engine" : engine}
