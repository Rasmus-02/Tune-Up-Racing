extends Node2D

var engine = null
var rpm = null
var turbo_charge = null
var turbo_flutter = null
var supercharger = null
var surging = false

func _ready():
	engine = get_parent().get_parent().get_parent()
	turbo_charge = $Turbo_charge
	turbo_flutter = $Turbo_flutter
	supercharger = $Supercharger

# Called when the node enters the scene tree for the first time.
func _process(_delta):
	if engine != null and engine.is_in_group("Engine"):
		rpm = engine.rpm
		running()
		sound_controller()

func running():
	if engine.is_running == true and turbo_charge.is_playing() == false and supercharger.is_playing() == false:
		if engine.turbo == true:
			turbo_charge.play()
		if engine.supercharger == true:
			supercharger.play()

func sound_controller():
	if engine.is_running == true:
		#Supercharger
		if engine.supercharger == true:
			supercharger.pitch_scale = rpm / 1500.0
			supercharger.volume_db = (10 + rpm / 1600.0 * engine.airflow_post_supercharger)
		#Turbo
		if engine.turbo == true:
			var sound_rng = randf_range(0.99, 1.02)
			turbo_charge.pitch_scale = (engine.boost_turbo ** 0.4 + 0.50) * sound_rng
			turbo_charge.volume_db = (-75 + 60 * engine.airflow_post_turbo ** 0.2)
			
			if engine.forward > 0 and engine.shift_cooldown != true:
				surging = false
			
			if ((engine.forward <= 0 and engine.dyno != 2 and engine.dyno != 3) or (engine.shift_cooldown and surging == false)) and turbo_flutter.is_playing() == false:
				surging = true
				turbo_flutter.volume_db = (-80 + 83 * (engine.boost_turbo / 3)**0.1)
				turbo_flutter.pitch_scale = 0.7 + (200.0 / engine.turbo_size) / 8.0 #Smaller Turbos higher pitch surge
				turbo_flutter.play()
	
	else:
		turbo_charge.stop()
		supercharger.stop()
