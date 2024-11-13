extends TextureProgressBar

var xp_to_next_level = null
@onready var level_sign = $Level

func _ready():
	update_level()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Update progress bar and give player xp
	if xp_to_next_level != null and xp_to_next_level != 0 and value != (Save_Load.xp / xp_to_next_level) * 100:
		value = (Save_Load.xp / xp_to_next_level) * 100
		Save_Load.save()
	
	#If reach next level xp, level up
	if Save_Load.xp >= xp_to_next_level:
		level_up()


func update_level(): #Update the xp_to_next_level stat
	xp_to_next_level = (1000 * Save_Load.level) #Require level times more xp to level up, for example lvl requires 10.000xp
	level_sign.text = ("LVL " + str(Save_Load.level)) #Update level text
	if Save_Load.level < 10:
		self_modulate = FontColorSettings.common
	if Save_Load.level >= 10:
		self_modulate = FontColorSettings.uncommon
	if Save_Load.level >= 20:
		self_modulate = FontColorSettings.rare
	if Save_Load.level >= 30:
		self_modulate = FontColorSettings.epic
	if Save_Load.level >= 40:
		self_modulate = FontColorSettings.legendary

func level_up():
	Save_Load.xp -= xp_to_next_level
	Save_Load.level += 1
	update_level()
