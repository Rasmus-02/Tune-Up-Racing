extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$"1000rpm".play()
	$"5000rpm".play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var slider_value = $HSlider.value
	var fade_out = 1.0 - slider_value  # Fade out for 1000rpm
	var fade_in = slider_value  # Fade in for 5000rpm
	if slider_value <= 1:
		$"1000rpm".volume_db = linear_to_db(fade_out)
		$"1000rpm".pitch_scale = 1 + $HSlider.value
		$"5000rpm".volume_db = linear_to_db(fade_in)
	$"5000rpm".pitch_scale = slider_value

func linear_to_db(value: float) -> float:
	if value <= 0:
		return -80  # Minimum volume in dB
	return 20 * log(value) / log(10)
