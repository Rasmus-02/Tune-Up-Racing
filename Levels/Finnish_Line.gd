extends Area2D

func _ready():
	Laptime.paused = true
	Laptime.reset_timer()

var complete_count = 0
func _on_body_entered(body):
	if body.is_in_group("Car") and body.velocity.x > 0: #velocity to check heading direction
		var car_position_node = body.get_node("AI").line_index
		var max_position_nodes = body.get_node("AI").racing_line.get_point_count()
		#Race Against AI
		if car_position_node >= max_position_nodes * 0.85: #Make sure that player has completed at least 85% of the lap
			
			if body.get_node("AI").lap == Placing.max_lap:
				complete_count += 1 #For each car that completes race, this goes up by one
			
			if body.player == true:
				#Check that not on final lap
				if body.get_node("AI").lap < Placing.max_lap:
					body.get_node("AI").lap += 1
				#If it is player that has finnished last lap, display race status by updating status to finnished
				else:
					RaceStatus.reward_bonus = body.reward_bonus()
					RaceStatus.player_position = complete_count
					RaceStatus.finished = true
			else: #For AI cars
				body.get_node("AI").lap += 1
			
			
			
		#Time Attack
		if Laptime.paused == true: #first lap
			Laptime.disqualified = false
			Laptime.paused = false
		else:
			Laptime.set_record()
	elif body.velocity.x <= 0:
		Laptime.disqualify()

