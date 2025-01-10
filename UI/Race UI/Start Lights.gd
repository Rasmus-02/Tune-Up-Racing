extends Sprite2D
var started = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if(event is InputEventKey or event is InputEventJoypadButton):
		if started == false:
			started = true
			start()

func start():
	$"Press Button Text".hide()
	$Timer.start()
	$Start_Sound.play()
	$Lights.play("Start")

func _on_timer_timeout():
	RaceStatus.started = true
	hide()

func _on_start_sound_finished():
	if Placing.car_list != null and Placing.car_list.size() > 0: #If restart button is pressed
		queue_free()
