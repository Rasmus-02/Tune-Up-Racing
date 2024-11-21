extends AudioStreamPlayer2D

@onready var shift_sound = $"."

var engine = null
func _ready():
	engine = get_parent().get_parent().get_parent().get_parent().get_parent()


var shift = false
func _process(_delta):
	if engine != null and engine.is_in_group("Engine"):
		if engine.shift_cooldown == true and shift == false:
			shift = true
			shift_sound.volume_db = 1.25 * Settings.car_volume
			shift_sound.play()
		elif engine.shift_cooldown == false:
			shift = false
