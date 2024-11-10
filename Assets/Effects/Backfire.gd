extends Node2D

var engine = null
var car = null
var backfire_level : float
var backfire_threshold : float
@onready var backfire_sound = $Backfire_Sound


func _ready():
	car = get_parent().get_parent().get_parent().get_parent().get_parent()
	if car != null and car.is_in_group("Car"):
		engine = car.engine

var temp_gear = 0
func _process(_delta):
	if engine != null and int(car.selected_engine) != 0 and engine.is_running == true and car.is_in_group("Car"):
		backfire_threshold = ((100.0 - engine.torque**0.5) * engine.smoothness)
		
		#increases and backfires when at threshold
		if engine.rpm >= engine.max_rpm -20:
			var backfire_increase_rng = randf_range(0, 3)
			var backfire_increase = (100 * (1 - engine.smoothness)) * (1 / engine.turbo_efficiency + engine.boost*5)
			if Input.is_action_pressed("Clutch"):
				backfire_level += (backfire_increase / 50) * backfire_increase_rng
			else:
				backfire_increase += (backfire_increase / 10) * backfire_increase_rng
		
		if Input.is_action_just_released("Forward") or car.gear != temp_gear:
			temp_gear = car.gear
			backfire_level += (1+engine.boost) * (engine.rpm/100) * (1 - engine.smoothness)
		
		#constantly go down a bit
		backfire_level -= 0.02
		backfire_level += engine.boost / 20.0
		backfire_level = clamp(backfire_level, 0, 999)
		
		#if over threshold, backfire
		if backfire_level > backfire_threshold:
			backfire_level -= backfire_threshold #reduce level after backfire
			var pitch_rng = randf_range(0.8, 1.2)
			var db_rng = randf_range(-12, 12) + engine.torque / 150 + engine.boost #louder with more torque
			backfire_sound.pitch_scale = pitch_rng
			backfire_sound.volume_db = db_rng
			backfire_sound.play()
			if db_rng > -5:
				for particle in self.get_child_count()-1:
					var emitter = self.get_child(particle+1).get_child(0)
					emitter.scale = Vector2(1 + db_rng/20-0.2 , 1 + db_rng/20-0.2)
					emitter.emitting = true
