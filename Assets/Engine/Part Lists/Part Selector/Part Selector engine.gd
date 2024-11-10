extends Node2D

var block = null
var internals = null
var top = null
var intake_manifold = null
var exhaust_manifold = null
var air_filter = null


var specific = null #part list specific for engine
var universal = null #part list for engine class
var spawn_engine = true #if true the engine will spawn from the parts
var update = false

@export var selected_block = 0
@export var selected_internals = 0
@export var selected_top = 0
@export var selected_intake_manifold = 0
@export var selected_exhaust_manifold = 0
@export var selected_air_filter = 0
@export var selected_engine = 0
@export var selected_engine_key = 0

func instantiate_engine():
	specific = get_child(0)
	universal = get_child(1)
	block = specific.block[selected_block].instantiate()
	internals = specific.internals[selected_internals].instantiate()
	top = specific.top[selected_top].instantiate()
	intake_manifold = specific.intake_manifold[selected_intake_manifold].instantiate()
	exhaust_manifold = specific.exhaust_manifold[selected_exhaust_manifold].instantiate()
	air_filter = universal.air_filter[selected_air_filter].instantiate()
	spawn_engine_by_parts()

func spawn_engine_by_parts():
	add_child(block)
	add_child(internals)
	add_child(top)
	add_child(intake_manifold)
	add_child(exhaust_manifold)
	exhaust_manifold.z_index += 1
	add_child(air_filter)
	#For Choosing where to spawn air filter and in what orientation
	if selected_intake_manifold != 0 and exhaust_manifold.turbo == false:
		air_filter.position.x = intake_manifold.get_node("Air filter location").position.x
		air_filter.position.y = intake_manifold.get_node("Air filter location").position.y
	#Set filter spawn position to exhaust if turbo == True
	if selected_exhaust_manifold != 0 and exhaust_manifold.turbo == true:
				air_filter.position.x = exhaust_manifold.get_node("Air filter location").position.x
				air_filter.position.y = exhaust_manifold.get_node("Air filter location").position.y
	#Rotate air filter correct way
	if selected_exhaust_manifold != 0 and exhaust_manifold.turbo == true or block.layout == "V":
		air_filter.rotation = deg_to_rad(-90)
	get_parent().get_parent().update()

func reload_engine():
	#despawns the engine
	if exhaust_manifold != null:
		exhaust_manifold.queue_free()
	if block != null:
		block.queue_free()
	if internals != null:
		internals.queue_free()
	if intake_manifold != null:
		intake_manifold.queue_free()
	if top != null:
		top.queue_free()
	if air_filter != null:
		air_filter.queue_free()
	#respawns the engine
	instantiate_engine()
