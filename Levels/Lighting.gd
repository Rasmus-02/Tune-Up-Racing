extends Node2D

@export var sun : Node2D
@export_enum("Sun", "Lamp") var Type : String
var sunrise = [0.8, Color(1, 0.98, 0.96), 0.4]
var day = [1, Color(1, 0.98, 0.96), 0.65]
var sunset = [0.8, Color(0.93, 0.66, 0.39), 0.4]
var night = [0.1, Color(0.6, 0.6, 0.6), 0.65]
var sunlight = [1, Color(1, 1, 1), 0.65]

var minute = 0 # Used as a delay to only update sunlight when minute is changed
func _physics_process(_delta):
	if Clock.minute != minute:
		minute = Clock.minute
		process_sunlight()

func process_sunlight():
	# Sunrise 06:00 - 11:59
	if Clock.hour >= 6 and Clock.hour < 8: # Night to sunrise 6 - 8 			(2 hrs)
		var offset = 2.0
		var time = float(Clock.hour) + (float(Clock.minute) * 0.01666)
		var progress = ((time - 6) / offset)
		print("progress :",progress)
		set_sunlight(transition(progress, night, sunrise))
	elif Clock.hour >= 8 and Clock.hour < 12: # Sunrise to day 8 - 12 			(4 hrs)
		var offset = 4.0
		var time = float(Clock.hour) + (float(Clock.minute) * 0.01666)
		var progress = ((time - 8) / offset)
		set_sunlight(transition(progress, sunrise, day))
	
	# Middle of day 12:00 - 17:59
	elif Clock.hour >= 12 and Clock.hour < 18:
		set_sunlight(day)
	
	# Sunset 18:00 - 21:59
	elif Clock.hour >= 18 and Clock.hour < 22: # Day to sunset 18 - 22 			(4 hrs)
		var offset = 4.0
		var time = float(Clock.hour) + (float(Clock.minute) * 0.01666)
		var progress = ((time - 18) / offset)
		set_sunlight(transition(progress, day, sunset))
	elif Clock.hour >= 22 and Clock.hour < 24: # Sunset to night 22 - 24 		(2 hrs)
		var offset = 2.0
		var time = float(Clock.hour) + (float(Clock.minute) * 0.01666)
		var progress = ((time - 22) / offset)
		set_sunlight(transition(progress, sunset, night))
	
	# Middle of night 22:00 - 05:59
	elif Clock.hour < 6:
		set_sunlight(night)

func transition(progress, light1, light2):
	var strenght = transition_value(progress, light1[0], light2[0]) # Transitions from light1 to light2 strenght
	var r = transition_value(progress, light1[1].r, light2[1].r)
	var g = transition_value(progress, light1[1].g, light2[1].g)
	var b = transition_value(progress, light1[1].b, light2[1].b)
	var color = Color(r,g,b)
	var height = transition_value(progress, light1[2], light2[2])
	return([strenght, color, height])

# Helper function for smooth transition between two values
func transition_value(progress ,value1, value2):
	return value1 - (value1 - value2) * progress

# Setter function for sunlight
func set_sunlight(new_sunlight):
	if new_sunlight != sunlight:
		sunlight = new_sunlight
	
	apply_changes(sun)
	if sun.get_child_count() > 0:
		for child_sun in sun.get_children():
			apply_changes(child_sun)

func apply_changes(selected_sun):
	selected_sun.energy = sunlight[0]
	selected_sun.color = sunlight[1]
	if Type == "Sun": # Only adjust height if using a directional light
		selected_sun.height = sunlight[2]
