extends Node2D

var loading = false
var changed = false
var next_scene = null
@export var background : Control
@onready var tip = $CanvasLayer/Control/Tip

func change_scene(scene):
	var rng = randi_range(0, tips.size()-1)
	if next_scene != null: #Will be Null at splashscreen
		tip.text = tips[rng]
	next_scene = scene
	loading = true
	transition_shader_value = 0.0
	$CanvasLayer.visible = true

func scene_changed():
	loading = false

var transition_shader_value = 0.0
func _physics_process(_delta):
	#Show Loading screen
	if loading == true and transition_shader_value <= 1.0:
		transition_shader_value += 0.005
	#Hide Loading screen
	elif transition_shader_value >= 0.0:
		transition_shader_value -= 0.005
		changed = false
	if transition_shader_value <= 0 and loading == false:
		$CanvasLayer.visible = false
	
	#Set the values to the loading screen
	transition_shader_value = clamp(transition_shader_value, 0.0, 1.0)
	background.material.set_shader_parameter("progress", transition_shader_value)
	
	#Actually load the scene after animation in main
	if transition_shader_value >= 1.0 and changed == false:
		changed = true
		#Load the scene in main
		get_parent().load_new_scene(next_scene)

var tips = ["Make sure to avoid knock by not exceeding the 'Max Compression' stat on your top end",
	"Compression is calculated based on the compression of your internals + boost",
	"Larger and less efficient turbos result in longer spoolup time",
	"You can adjust your cars gearing if you need better top speed or faster acceleration",
	"If you run a twin-charged setup, make sure to account for the superchargers boost",
	"Remember, any engine can be swapped into any car as long as it fits",
	"Wheels, Tires, Brakes, Suspension and Radiators are interchangeable between cars",
	"The Top-End can change the sound of Engines significantly",
	"For every 10 levels up to level 40 new parts will be available for purchase",
	"If Progress feels slow, try increasing the Difficulty",
	"The size of an Engine is determined by all the parts on said Engine",
	"Remember, more horsepower isn't always better; a good powerband is also important",
	"Downforce helps your car maintain grip through corners at high speeds"]
