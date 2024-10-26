extends Area2D

func _ready():
	Laptime.paused = true
	Laptime.reset_timer()

func _on_body_entered(body):
	if body.is_in_group("Car") and body.velocity.x > 0: #velocity to check heading direction
		#Race Against AI
		body.get_node("AI").lap += 1
		#Time Attack
		if Laptime.paused == true: #first lap
			Laptime.disqualified = false
			Laptime.paused = false
		else:
			Laptime.set_record()
	elif body.velocity.x <= 0:
		Laptime.disqualify()

