extends Node2D

var chassi = null
var driveshaft = null
var subframe = null
var fenders = null
var f_bumper = null
var r_bumper = null
var hood = null
var headlights = null
var taillights = null
var spoiler = null
var mirrors = null
var brakes = null
var suspension = null
var tires = null
var wheels = null
var gearbox = null
var radiator = null
var exhaust = null

var engine_position = Vector2(0,0)
var engine_position_offset = Vector2(0,0)

var specific = null #part list specific for car
var universal = null #part list for car class
var spawn_car = true #if true the car will spawn from the parts
var update = false

@export var selected_car_key = 0
@export var selected_engine = 0
@export var selected_chassi = 0
@export var selected_driveshaft = 0
@export var selected_subframe = 0
@export var selected_fenders = 0
@export var selected_f_bumper = 0
@export var selected_r_bumper = 0
@export var selected_hood = 0
@export var selected_headlights = 0
@export var selected_taillights = 0
@export var selected_spoiler = 0
@export var selected_mirrors = 0
@export var selected_brakes = 0
@export var selected_suspension = 0
@export var selected_tires = 0
@export var selected_wheels = 0
@export var selected_gearbox = 0
@export var selected_radiator = 0
@export var selected_exhaust = 0
@export var in_garage = 0
var suspension_list = [null,null,null,null]
var wheel_list = [null,null,null,null]
var tire_list = [null,null,null,null]
var brake_list = [null,null,null,null]

func instantiate_car():
	specific = get_child(0)
	universal = get_child(1)
	chassi = specific.chassi[selected_chassi].instantiate()
	driveshaft = specific.driveshaft[selected_driveshaft].instantiate()
	subframe = specific.subframe[selected_subframe].instantiate()
	fenders = specific.fenders[selected_fenders].instantiate()
	f_bumper = specific.f_bumper[selected_f_bumper].instantiate()
	r_bumper = specific.r_bumper[selected_r_bumper].instantiate()
	hood = specific.hood[selected_hood].instantiate()
	headlights = specific.headlights[selected_headlights].instantiate()
	taillights = specific.taillights[selected_taillights].instantiate()
	spoiler = specific.spoiler[selected_spoiler].instantiate()
	mirrors = specific.mirrors[selected_mirrors].instantiate()
	gearbox = universal.gearbox[selected_gearbox].instantiate()
	radiator = universal.radiator[selected_radiator].instantiate()
	exhaust = specific.exhaust[selected_exhaust].instantiate()
	subframe.z_index = 10
	exhaust.z_index = 10
	driveshaft.z_index = 20
	gearbox.z_index = 30
	#engine = 30
	chassi.z_index = 40
	radiator.z_index = 45
	r_bumper.z_index = 50
	f_bumper.z_index = 60
	headlights.z_index = 70
	taillights.z_index = 80
	fenders.z_index = 90
	hood.z_index = 100
	spoiler.z_index = 110
	mirrors.z_index = 120
	spawn_car_by_parts()

func spawn_car_by_parts():
	add_child(subframe)
	add_child(exhaust)
	add_child(driveshaft)
	for i in 4:
		#need to instantiate again to spawn again
		brakes = universal.brakes[selected_brakes].instantiate()
		suspension = universal.suspension[selected_suspension].instantiate()
		tires = universal.tires[selected_tires].instantiate()
		wheels = universal.wheels[selected_wheels].instantiate()
		brakes.z_index = 21
		wheels.z_index = 22
		tires.z_index = 23
		suspension.z_index = 24
		var wheel_offset = 8
		if i == 0 or i == 1:
			wheel_offset = wheel_offset * -1
		else:
			brakes.get_child(0).scale.y = -1
			wheels.get_child(0).scale.y = -1
			tires.get_child(0).scale.y = -1
			suspension.get_child(0).scale.y = -1
		add_child(brakes)
		brake_list[i] = brakes
		brakes.position.x = chassi.get_child(i+1).position.x
		brakes.position.y = chassi.get_child(i+1).position.y+ wheel_offset
		add_child(wheels)
		wheel_list[i] = wheels
		wheels.position.x =  chassi.get_child(i+1).position.x
		wheels.position.y =  chassi.get_child(i+1).position.y + wheel_offset
		add_child(tires)
		tire_list[i] = tires
		tires.position.x = chassi.get_child(i+1).position.x
		tires.position.y = chassi.get_child(i+1).position.y + wheel_offset
		add_child(suspension)
		suspension_list[i] = suspension
		suspension.position.x = chassi.get_child(i+1).position.x
		suspension.position.y = chassi.get_child(i+1).position.y
	add_child(gearbox)
	add_child(radiator)
	add_child(chassi)
	add_child(headlights)
	add_child(taillights)
	add_child(r_bumper)
	add_child(f_bumper)
	add_child(fenders)
	add_child(hood)
	add_child(spoiler)
	add_child(mirrors)
	#Line up position of gearbox and engine to driveshaft
	if selected_gearbox != 0:
		var gb_position = gearbox.get_node("Driveshaft").position
		var ds_position = driveshaft.get_node("Gearbox").position
		var Gearbox_change_x = ds_position.x - gb_position.x 
		var Gearbox_change_y = ds_position.y - gb_position.y
		gearbox.position.x = gb_position.x + Gearbox_change_x
		gearbox.position.y = gb_position.y + Gearbox_change_y
		if gearbox.drivetrain == 1: #rotate if FWD
			gearbox.rotation = deg_to_rad(-90)
			engine_position =  Vector2(gearbox.get_node("Engine").global_position) #set position signal that gets sent to engine
			#calculate how far from start of engine bay (lenght = x) and how far from center of engine bay (width = y)
			engine_position_offset = Vector2(ds_position.x - chassi.engine_bay_start_lenght-  gearbox.get_node("Engine").position.y ,driveshaft.global_position.y - engine_position.y)
		else:
			gearbox.rotation = deg_to_rad(0)
			engine_position =  Vector2(gearbox.get_node("Engine").global_position) #set position signal that gets sent to engine
			#calculate how far from start of engine bay (lenght = x) and how far from center of engine bay (width = y)
			engine_position_offset = Vector2(ds_position.x - chassi.engine_bay_start_lenght + gearbox.get_node("Engine").position.x ,driveshaft.global_position.y - engine_position.y)
	radiator_loaded = false
	get_parent().get_parent().update()

var radiator_loaded = false
func radiator_constructor():
	#set radiator position and piping
	var engine = get_parent().get_parent().get_parent().get_node("Engine").get_node("Engine_spawner").get_child(0)
	if selected_radiator != 0 and engine != null and radiator != null:
		var piping_car =  chassi.get_node("Radiator_Location").position
		var piping_engine = driveshaft.get_node("Gearbox").position + gearbox.get_node("Engine").position + Vector2(39,0)
		var extra_pipe_lenght = 0
		if gearbox.drivetrain == 0 or gearbox.drivetrain == 2:
			extra_pipe_lenght = abs((piping_car - piping_engine).x)
		else:
			extra_pipe_lenght = piping_car.x - driveshaft.get_node("Gearbox").position.x - gearbox.get_node("Engine").position.y - (13+4)
		
		for i in radiator.get_node("Piping").get_child_count(): #Hide all other piping
			radiator.get_node("Piping").get_child(i).visible = false
		if int(extra_pipe_lenght)%2 == 1: #Make the piping even because it scales by 2
			extra_pipe_lenght += 1
		if extra_pipe_lenght > 1 and extra_pipe_lenght < 21:
			radiator.get_node("Piping").get_node(str(extra_pipe_lenght)).visible = true #Show the correct pipe lenght
		
		radiator.global_position = chassi.get_node("Radiator_Location").global_position
		radiator.rotation = deg_to_rad(-90)
		if gearbox.drivetrain == 0 or gearbox.drivetrain == 2: #select trans or long piping depending on drivetrain
			if engine.get_node("Radiator_Piping_Longitudinal") != null and engine.get_node("Radiator_Piping_Transverse") != null:
				engine.get_node("Radiator_Piping_Longitudinal").visible = true
				engine.get_node("Radiator_Piping_Transverse").visible = false
				radiator_loaded = true
		else:
			if engine.get_node("Radiator_Piping_Longitudinal") != null and engine.get_node("Radiator_Piping_Transverse") != null:
				engine.get_node("Radiator_Piping_Transverse").visible = true
				engine.get_node("Radiator_Piping_Longitudinal").visible = false
				radiator_loaded = true

func reload_car():
	#despawns the car
	if chassi != null:
		chassi.queue_free()
	if driveshaft != null:
		driveshaft.queue_free()
	if subframe != null:
		subframe.queue_free()
	if fenders != null:
		fenders.queue_free()
	if f_bumper != null:
		f_bumper.queue_free()
	if r_bumper != null:
		r_bumper.queue_free()
	if hood != null:
		hood.queue_free()
	if headlights != null:
		headlights.queue_free()
	if taillights != null:
		taillights.queue_free()
	if spoiler != null:
		spoiler.queue_free()
	if mirrors != null:
		mirrors.queue_free()
	if gearbox != null:
		gearbox.queue_free()
	if radiator != null:
		radiator.queue_free()
	if exhaust != null:
		exhaust.queue_free()
	for i in 4:
		if suspension_list[i] != null:
			suspension_list[i].queue_free()
		if brake_list[i] != null:
			brake_list[i].queue_free()
		if tire_list[i] != null:
			tire_list[i].queue_free()
		if wheel_list[i] != null:
			wheel_list[i].queue_free()
	#respawns the car
	instantiate_car()

func _process(_delta):
	if radiator_loaded == false:
		radiator_constructor()
	if update == true:
		radiator_loaded = false
		reload_car()
		update = false
