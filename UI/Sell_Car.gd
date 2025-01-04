extends Node

var car : CharacterBody2D

func _on_yes_pressed():
	Save_Load.money += car.get_value() * 0.8
	Save_Load.remove_car(car.selected_car_key)
	if car.selected_engine != "0":
		Save_Load.remove_engine(car.selected_engine)
	car.queue_free()
	close()

func _on_no_pressed():
	close()


func open(import_car):
	get_parent().pause_blocked = true
	car = import_car
	$"Sell Car/Label".text = "Do you want to sell this car for: " + format_number(car.get_value() * 0.8) + "$"
	self.visible = true

func close():
	get_parent().pause_blocked = false
	self.visible = false



func format_number(num: int) -> String:
	var num_str = str(num)
	var result = ""
	var count = 0
	
	for i in range(num_str.length() - 1, -1, -1):
		result = num_str[i] + result
		count += 1
		if count % 3 == 0 and i != 0:
			result = "." + result  # Insert period as thousand separator
	
	return result
