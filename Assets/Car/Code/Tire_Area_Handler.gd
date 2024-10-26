extends Area2D

var on_road = false

func _process(_delta):
	var temp_on_road = false
	for i in get_overlapping_areas().size():
		if get_overlapping_areas()[i].name == "Road_Area":
			on_road = true
			temp_on_road = true
		elif i >= get_overlapping_areas().size() - 1 and !temp_on_road:
			on_road = false
