extends Node2D

@export var Racing_Line : Line2D

func handle_body(body):
	if body.is_in_group("Car"):
		if body.loaded == false:
			body.get_node("AI").import_racing_line(Racing_Line)
			Placing.car_list.append(body)

func _on_start_body_entered(body):
	handle_body(body)
