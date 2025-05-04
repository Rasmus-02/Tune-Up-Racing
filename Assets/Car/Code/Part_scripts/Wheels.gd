extends Node2D

@export_category("ID")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String
@export_enum("Iron", "Aluminium", "Magnesium", "Titanium", "Plasitc", "Carbon Fiber", "Rubber") var part_material : int
var Car_ID = 9999
@export var Part_Number : int
var type = 0 #car or engine
var id = [Car_ID,14,Part_Number,rarity] #Engine ID, Part type, Part number, rank
@export_multiline var description = ""

@export_category("Stats")
@export_range(0 , 10000000) var price : int
@export var weight = 0
@export var max_tire_width = 220
@export var diameter = 0
@export var brake_cooling = 0.0 #Celcius per second (road: 1-3, race: 2-5)

var durability = 100 #100%
var color = 0

var seed = 1 #A Seed for the perlin noise of the durability shader
var car
func _ready():
	if get_parent() != null and get_parent().get_parent() != null and get_parent().get_parent().get_parent() != null:
		car = get_parent().get_parent().get_parent().get_parent()
	
func _process(_delta):
	if (current_durability == null or durability != current_durability):
		if car != null and car.is_in_group("Car"):
			apply_durability(car.wheels_durability)
		elif get_parent().is_in_group("Computer"):
				apply_durability(get_parent().get_parent().get_parent().selected_durability)

var current_durability = null
func apply_durability(durability):
	var new_material = ShaderMaterial.new()
	var shader = preload("res://Shaders/Test/Paint_Durability.gdshader")
	new_material.shader = shader
	if $Sprite2D:
		$Sprite2D.material = new_material
		current_durability = durability
		$Sprite2D.material.set_shader_parameter("sensitivity", 1 - (durability * 0.01))
		$Sprite2D.material.set_shader_parameter("material_type", part_material)
		var noise = preload("res://Shaders/Durability Noisemap.tres")
		$Sprite2D.material.set_shader_parameter("noise_texture", noise)
		$Sprite2D.material.get_shader_parameter("noise_texture").noise.seed = seed





# ORPHAN NODE HANDLER, DELETE WHEN SCENE CHANGE
func _init():
	Utils.connect("freeing_orphans", Callable(self, "_free_if_orphaned"))
func _free_if_orphaned():
	if not is_inside_tree(): # Optional check - don't free if in the scene tree
		queue_free()
