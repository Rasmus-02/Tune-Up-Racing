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
			get_child(i).load_car_from_algorithm(car)
			get_child(i).engine.load_car_from_algorithm(engine)
		loaded = true




func get_ai_car():
	var rarity = player.get_child(0).current_car[2]
	var weight = player.weight
	var grip = player.max_tire_limit
	var downforce = player.downforce
	var brake_force = player.brake_force
	var tq = player.engine.max_torque * (player.engine.compression / 10)
	print("pre",tq)
	#make the max limit account for boost
	if player.engine.turbo == true:
		tq += player.engine.max_torque * (player.engine.max_boost * (player.engine.turbo_size/70)*player.engine.turbo_efficiency)
	if player.engine.supercharger == true:
		tq += player.engine.max_torque * ((player.engine.supercharer_displacement_capacity * 0.0004))
	print("post",tq)
	var car = null
	var engine = null
	var step = 0 #TESTING TOOL TO BENCHMARK PERFORMANCE
	#Generate a car that isn't null
	while car == null:
		step += 1
		car = generate_car(rarity, weight, tq, grip, downforce, brake_force)
		
		#Try 3 time to find an engine
		for i in 3:
			engine = generate_engine(weight, car.weight, tq, car.engine_bay_size, car.position_offset, car.drivetrain, car.stock_engine)
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
