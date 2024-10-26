extends Node2D



func _on_above_bridge_body_entered(body):
	if body.is_in_group("Car"):
		body._on_above_bridge_body_entered()

func _on_above_bridge_body_exited(body):
	if body.is_in_group("Car"):
		body._on_above_bridge_body_exited()

func _on_bellow_bridge_body_entered(body):
	if body.is_in_group("Car"):
		body._on_bellow_bridge_body_entered()

func _on_bellow_bridge_body_exited(body):
	if body.is_in_group("Car"):
		body._on_bellow_bridge_body_exited()
