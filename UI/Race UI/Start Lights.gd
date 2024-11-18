extends Sprite2D
var started = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(_event):
	if Input.is_action_just_pressed("ui_accept"):
		if started == false:
			started = true
			start()

func start():
	$"Press Button Text".hide()
	$Timer.start()
	$Lights.play("Start")

func _on_timer_timeout():
	RaceStatus.started = true
	queue_free()
