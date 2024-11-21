extends Node2D
var rpm = 0.0
var engine = null
var throttle_1000 = null
var no_throttle_1000 = null
var throttle_4000 = null
var no_throttle_4000 = null
var airflow = null


func _ready():
	engine = get_parent().get_parent().get_parent().get_parent().get_parent()
	throttle_1000 = $engine_sound_throttle_1000rpm
	no_throttle_1000 = $engine_sound_no_throttle_1000rpm
	throttle_4000 = $engine_sound_throttle_4000rpm
	no_throttle_4000 = $engine_sound_no_throttle_4000rpm
	airflow = $Airflow

func _process(_delta):
	if engine != null and engine.is_in_group("Engine"):
		rpm = engine.rpm
		running()
		sound_controller()

func running():
	if engine.is_running == true and no_throttle_1000.is_playing() == false:
		throttle_1000.play()
		no_throttle_1000.play()
		throttle_4000.play()
		no_throttle_4000.play()
		airflow.play()


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
		
		var slider_value = (rpm/4000.0)
		var fade_out = 1.0 - slider_value  # Fade out for 1000rpm
		var fade_in = slider_value  # Fade in for 5000rpm
		
		throttle_1000.pitch_scale = 1 + slider_value * knock_rng
		no_throttle_1000.pitch_scale = 1 + slider_value * knock_rng
		throttle_4000.pitch_scale = slider_value * 1.2 * knock_rng
		no_throttle_4000.pitch_scale = slider_value * 1.2 * knock_rng
		
		
		if (engine.forward > 0 or engine.dyno == 2 or engine.dyno == 3) and engine.shift_cooldown != true:
			airflow.volume_db = (-20 + (rpm / 600.0) ** 0.8)
			if slider_value <= 1:
				throttle_1000.volume_db = ((linear_to_db(fade_out) - 6) - engine.volume_dampening_car)
				throttle_4000.volume_db = ((linear_to_db(fade_in) +6) - engine.volume_dampening_car)
			else:
				throttle_4000.volume_db = ((slider_value ** 0.5 * 5) - engine.volume_dampening_car)#max volume
			no_throttle_4000.volume_db = -80
			no_throttle_1000.volume_db = -80
			
			
		else:
			if slider_value <= 1:
				no_throttle_1000.volume_db = ((linear_to_db(fade_out) - 6) - engine.volume_dampening_car)
				no_throttle_4000.volume_db = ((linear_to_db(fade_in) + 6) - engine.volume_dampening_car)
			else:
				no_throttle_4000.volume_db = ((slider_value ** 0.5 * 5) - engine.volume_dampening_car) #max volume
			airflow.volume_db = -80
			throttle_4000.volume_db = -80
			throttle_1000.volume_db = -80
	
	else:
		throttle_1000.stop()
		no_throttle_1000.stop()
		throttle_4000.stop()
		no_throttle_4000.stop()
		airflow.stop()


func linear_to_db(value: float) -> float:
	if value <= 0:
		return -80  # Minimum volume in dB
	return 20 * log(value) / log(10)


