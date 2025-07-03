extends Sprite2D

var car
var ai_group
var correction_vector = Vector2(10, 100)
var map_scale = 0.0122
var icon = preload("res://UI/Race UI/minimap_icon.tscn")
var icon_array = []
var player_color = Color(0.78039216995239, 0, 0)
var AI1_color = Color(0, 0, 0.78039216995239)
var AI2_color = Color(0, 0.78039216995239, 0)
var AI3_color = Color(0.86274510622025, 0.91372549533844, 0)
var AI4_color = Color(0.78039216995239, 0, 0.78039216995239)
var AI5_color = Color(0, 0.78039216995239, 0.78039216995239)
var AI6_color = Color(0.75443208217621, 0.42937695980072, 0.00000038504601)
var AI7_color = Color(0.70588237047195, 0.70588237047195, 0.70588237047195)

func _ready():
	await get_tree().create_timer(1).timeout
	car = get_parent().get_parent().get_child(0).get_child(0).get_child(0).get_node("Player").get_node("Car")
	ai_group = get_parent().get_parent().get_child(0).get_child(0).get_child(0).get_node("AI")
	var color_array = [player_color, AI1_color, AI2_color, AI3_color, AI4_color, AI5_color, AI6_color, AI7_color]
	for i in ai_group.get_child_count()+1: #+1 is the player
		var new_icon = icon.instantiate()
		add_child(new_icon)
		new_icon.set_modulate(color_array[i]) #Set Color
		if i == 0:
			new_icon.z_index += 1
		icon_array.append(new_icon) #Add to array of all nodes

func set_map_layout(map):
	texture = map


func _process(_delta):
	if car != null and Placing.car_list != []:
		correction_vector  = Vector2(63, -164)
		map_scale = 0.0122
		#AI -1 to remove player
		for i in icon_array.size() - 1:
			var ai_car = ai_group.get_child(i) #GET THE RIGHT AI CAR
			icon_array[i+1].global_position = correction_vector + global_position + ai_car.global_position * map_scale
		#PLAYER
		icon_array[0].global_position = correction_vector + global_position + car.global_position * map_scale
