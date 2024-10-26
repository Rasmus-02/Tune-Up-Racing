extends Node2D

var max_horsepower = 1
var max_torque = 1
var max_rpm = 1
var max_horsepower_rpm = 1
var compression = 1#1
var max_boost = 1
var turbo = false
var supercharger = false
var turbo_spool_rpm = 1
var turbo_size = 1 #compressor size
var supercharer_spool_rate = 1
var weight = 1
var update = false
var width_left = 1
var width_right = 1
var lenght_front = 1
var lenght_rear = 1

var boost_mod = 1 #not implemented yet

func update_stats():
	var node = get_node("Part Selector")
	var block = node.block
	var internals = node.internals
	var top = node.top
	var intake_manifold = node.intake_manifold
	var exhaust_manifold = node.exhaust_manifold
	var air_filter = node.air_filter
	var radiator = node.radiator
	
	#Calculate size of the engine:
	width_left = (block.width) * 0.5 + intake_manifold.width
	width_right = (block.width) * 0.5 + exhaust_manifold.width
	if radiator.orientation == "side" and radiator.width > exhaust_manifold.width:
		width_right = (block.width) * 0.5 + radiator.width
	
	lenght_front = (block.lenght) * 0.5 + air_filter.lenght
	if radiator.orientation == "front" and radiator.lenght > air_filter.lenght:
		lenght_front = radiator.lenght
	lenght_rear = (block.lenght) * 0.5
	if get_tree().get_current_scene().get_name() == "Engine Builder":
			get_parent().get_parent().get_parent().get_node("Control").get_node("ItemList").updated = true
	get_parent().update()
