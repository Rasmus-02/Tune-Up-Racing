extends Label

@onready var date = $"../Date"
@onready var sun_status = $"../Sunstatus"
var minute : String
var hour : String

func _process(_delta):
	#Set time
	if Clock.minute >= 10:
		minute = str(Clock.minute)
	else:
		minute = "0" + str(Clock.minute)
	
	if Clock.hour >= 10:
		hour = str(Clock.hour)
	else:
		hour = "0" + str(Clock.hour) 
	
	text = hour + ":" + minute
	#Set day 
	match Clock.day:
		1:
			date.text = "Mon"
			date.add_theme_color_override("font_color", Color(1,1,1))
		2:
			date.text = "Tue"
			date.add_theme_color_override("font_color", Color(1,1,1))
		3:
			date.text = "Wed"
			date.add_theme_color_override("font_color", Color(1,1,1))
		4:
			date.text = "Thu"
			date.add_theme_color_override("font_color", Color(1,1,1))
		5:
			date.text = "Fri"
			date.add_theme_color_override("font_color", Color(1,1,1))
		6:
			date.text = "Sat"
			date.add_theme_color_override("font_color", Color(0.98039215803146, 0.37254902720451, 0.36078432202339))
		7:
			date.text = "Sun"
			date.add_theme_color_override("font_color", Color(0.98039215803146, 0.37254902720451, 0.36078432202339))
	
	#Sunrise 6-9
	#Day 9 - 19
	#Sunset 19 - 22
	#Night 22 - 6
	#Sun Status
	if Clock.hour >= 6 and Clock.hour < 9:
		sun_status.frame = 0
	elif Clock.hour >= 9 and Clock.hour < 19:
		sun_status.frame = 1
	elif Clock.hour >= 19 and Clock.hour < 22:
		sun_status.frame = 2
	elif Clock.hour >= 22 or Clock.hour < 6:
		sun_status.frame = 3
	
