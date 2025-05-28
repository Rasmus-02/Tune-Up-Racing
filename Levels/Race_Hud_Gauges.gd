extends Sprite2D

var car : CharacterBody2D
var rpm : float
var max_rpm : float
var boost : float
var temperature : float
var speed : int
var gear : int
@onready var rpm_dial = $RPM
@onready var boost_dial = $Boost
@onready var boost_digital = $Boost_Text
@onready var temperature_dial = $Temperature
@onready var hybrid_gauge = $"Hybrid Power"
@onready var speed_dial = $Speed
@onready var gear_dial = $Gear
@onready var current_time = $"../../Current Time"
@onready var record_time = $"../../Record Time"
@onready var position_indicator = $"../../Position"
@onready var lap_indicator = $"../../Lap Count"

func _ready():
	await get_tree().create_timer(1).timeout
	car = get_parent().get_parent().get_parent().get_child(0).get_child(0).get_child(0).get_node("Player").get_node("Car")

func _physics_process(_delta):
	if car != null and car.loaded == true:
		update_stats()
		rotate_dial(rpm_dial, rpm/max_rpm, -160, 50)
		rotate_dial(boost_dial, boost/3.0, -180, 90)
		rotate_dial(temperature_dial, temperature/100.0, -130, 40)
		update_text_dial(speed_dial, speed)
		update_text_dial(gear_dial, gear)
		update_text_dial(boost_digital, boost)
		update_text_dial(position_indicator, "Position: " + str(Placing.player_placing) + "/" + str(Placing.car_list.size()))
		update_text_dial(lap_indicator, "Lap: " + str(Placing.player_lap) + "/" + str(Placing.max_lap))
		if Laptime.get_current() != null:
			update_text_dial(current_time, "Current: " + Laptime.get_current())
		if Laptime.get_record() != null:
			update_text_dial(record_time, "Record: " + Laptime.get_record())


func rotate_dial(dial, value, lower_limit, upper_limit):
	if dial != null:
		var new_rotation = deg_to_rad(value * abs(lower_limit - upper_limit)+lower_limit)
		new_rotation = clamp(new_rotation, deg_to_rad(lower_limit), deg_to_rad(upper_limit))
		dial.rotation = lerp_angle(dial.rotation, new_rotation, 0.10)


func update_text_dial(dial, value):
	if dial != null:
		if value is float or value is int:
			dial.set_text(str(snapped(value, 0.1)))
		elif value is String:
			dial.set_text(value)



func update_stats():
	rpm = float(car.engine_rpm)
	max_rpm = float(car.max_engine_rpm)
	boost = float(car.engine.boost)
	temperature = float(car.engine.temperature)
	speed = int(car.speed_kmh)
	gear = int(car.gear-1)
	
