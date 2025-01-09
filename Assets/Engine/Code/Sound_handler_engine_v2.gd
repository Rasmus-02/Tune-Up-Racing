extends Node2D
var rpm = 0.0
var engine = null
var throttle_low = null
var no_throttle_low = null
var throttle_high = null
var no_throttle_high = null
@onready var airflow = $"../Airflow"
var slider_value = 1.0
@export var aiflow_db = -28
@onready var sounds = $"."


func _ready():
	engine = get_parent().get_parent().get_parent().get_parent().get_parent()

func _process(_delta):
	if engine != null:
		rpm = engine.rpm
		running()
		sound_controller()

func running():
	if engine.is_running == true and no_throttle_low == null:
		select_track()
		#airflow.play()


var knock_delay : int
func sound_controller():
	var knock = 0
	knock_delay += engine.knock()*2
	if knock_delay > 50:
		knock_delay = 0
		knock = engine.knock()
	if engine.is_running == true:
		var knock_rng = randf_range(1-knock, 1)
		airflow.pitch_scale = 0.25 + (rpm / 25000.0)
		
		select_track()
		
		if get_child_index() <= sounds.get_child_count() / 2:
			slider_value = ((int(rpm) % 1000) / 1000.0) #get rpm as 1000 more than current rpm
			slider_value = clamp(slider_value,0.01,1)
			throttle_low.pitch_scale = 1 * knock_rng
			no_throttle_low.pitch_scale = 1 * knock_rng
			throttle_high.pitch_scale = 1 * knock_rng
			no_throttle_high.pitch_scale = 1 * knock_rng
		else:
			slider_value = (rpm/sounds.get_child_count() * 500) #get the max rpm *0.5 and *1000 = *500
			throttle_low.pitch_scale = 1 * knock_rng
			no_throttle_low.pitch_scale = 1 * knock_rng
			throttle_high.pitch_scale = slider_value * knock_rng
			no_throttle_high.pitch_scale = slider_value * knock_rng
		
		var fade_out = 1.0 - slider_value  # Fade out for 1000rpm
		var fade_in = slider_value  # Fade in for 5000rpm
		
		print(no_throttle_low.playing," ", throttle_low.playing," ", no_throttle_high.playing," ", throttle_high.playing,"  ", get_rpm(),"    fade in: ",fade_in," ", linear_to_db(fade_in), "    fade out: ", fade_out, " ", linear_to_db(fade_out))
		
		#engine.forward > 0 or 
		if (engine.dyno == 2 or engine.dyno == 3) and engine.shift_cooldown != true:
			airflow.volume_db = aiflow_db
			airflow.volume_db = -20 + rpm / 600.0
			if slider_value <= 1:
				throttle_low.volume_db = (lin_to_db(fade_out)) - engine.volume_dampening_car
				throttle_high.volume_db = (lin_to_db(fade_in)) - engine.volume_dampening_car
			else:
				throttle_high.volume_db = (lin_to_db(fade_in)) - engine.volume_dampening_car#max volume
			no_throttle_high.volume_db = -80
			no_throttle_low.volume_db = -80
			
		else:
			if slider_value <= 1:
				no_throttle_low.volume_db = (lin_to_db(fade_out)) - engine.volume_dampening_car
				no_throttle_high.volume_db = (lin_to_db(fade_in)) - engine.volume_dampening_car
			else:
				no_throttle_high.volume_db = (lin_to_db(fade_in)) - engine.volume_dampening_car #max volume
			airflow.volume_db = -80
			throttle_high.volume_db = -80
			throttle_low.volume_db = -80
	
	#else:
	#	throttle_low.stop()
	#	no_throttle_low.stop()
	#	throttle_high.stop()
	#	no_throttle_high.stop()
	#	airflow.stop()

var temp_low_throttle = null
var temp_high_throttle = null
var temp_low_no_throttle = null
var temp_high_no_throttle = null
var temp_index = null
func select_track():
	#If temp index not same and within sound track range
	if temp_index != get_child_index() and get_child_index() <= sounds.get_child_count() / 2: 
		#Set current tracks to temp
		temp_low_throttle = throttle_low
		temp_high_throttle = throttle_high
		temp_low_no_throttle = no_throttle_low
		temp_high_no_throttle = no_throttle_high
		#Stop old tracks
		if temp_low_throttle != null:
			temp_low_throttle.stop()
			temp_high_throttle.stop()
			temp_low_no_throttle.stop()
			temp_high_no_throttle.stop()
		#Select the new tracks | *2 to get the correct index because nt and t, +1 to offset to nt, and +1 before *2 to get the next 1000 rpm
		throttle_low = sounds.get_child(get_child_index()*2)
		throttle_high = sounds.get_child((get_child_index()+1)*2)
		no_throttle_low = sounds.get_child(get_child_index()*2 + 1)
		no_throttle_high = sounds.get_child((get_child_index()+1)*2 + 1)
		#Play new tracks
		throttle_low.play()
		throttle_high.play()
		no_throttle_low.play()
		no_throttle_high.play()
		#print("tl low: ",throttle_low.playing)

		#reassign temp index
		temp_index = get_child_index()

func get_rpm():
	return float ((round((rpm) /1000) * 1000))

func get_child_index():
	return int(get_rpm() / 1000) - 1

func lin_to_db(value: float) -> float:
	if value <= 0.01:  # Set a small threshold to avoid -80dB jumps
		return -80  # Minimum volume for smoother transition
	return 20 * log(value) / log(10)


