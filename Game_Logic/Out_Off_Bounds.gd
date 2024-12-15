extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Car"):
		body.out_of_bounds()
