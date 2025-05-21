extends collidable_part

@export_category("ID")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String
@export_enum("Iron", "Aluminium", "Magnesium", "Titanium", "Plasitc", "Carbon Fiber", "Rubber") var part_material : int
@export_range(0, 80) var engine_bay_lenght : int
@export_range(0, 80) var engine_bay_width : int
@export_range(0, 120) var engine_bay_start_lenght : int
@export var Car_ID : int
@export var Part_Number : int
var type = 0 #car or engine
var id = [Car_ID,0,Part_Number,rarity] #Engine ID, Part type, Part number, rank
@export_multiline var description = ""

@export_category("Stats")
@export var paintable = true
@export_range(0 , 10000000) var price : int
@export var weight = 0
@export_range(0, 1, 0.01) var reliability : float
@export var downforce = 0 #Kg @ 100kmh
@export var drag = 0.0 #drag coeff
@export var wheelbase = 0 #pixels

var durability = 100 #100%
var color = 0



#For Painting the part
var seed = 1 #A Seed for the perlin noise of the durability shader
var car
func _ready():
	if get_parent() != null and get_parent().get_parent() != null and get_parent().get_parent().get_parent() != null:
		car = get_parent().get_parent().get_parent().get_parent()
	update_hitbox(car)
	
func _process(_delta):
	if (current_color == null or color != current_color or durability != current_durability):
		if car != null and car.is_in_group("Car"):
			paint_part(car.chassi_color, car.chassi_durability)
		elif get_parent().is_in_group("Computer"):
			var selected_color = get_parent().get_parent().get_parent().selected_color
			var selected_durability = get_parent().get_parent().get_parent().selected_durability
			paint_part(selected_color, selected_durability)

var current_color = null
var current_durability = null
func paint_part(color_index, durability):
	color = color_index
	var new_material = ShaderMaterial.new()
	var shader = preload("res://Shaders/Test/Paint_Durability.gdshader")
	new_material.shader = shader
	if $Sprite2D:
		$Sprite2D.material = new_material
		var new_color = Colors.list[color_index][0]
		current_color = color_index
		current_durability = durability
		#Color
		$Sprite2D.material.set_shader_parameter("import_new_color", new_color)
		#Durability
		$Sprite2D.material.set_shader_parameter("sensitivity", 1 - (durability * 0.01))
		$Sprite2D.material.set_shader_parameter("material_type", part_material)
		var noise = preload("res://Shaders/Durability Noisemap.tres")
		$Sprite2D.material.set_shader_parameter("noise_texture", noise)
		$Sprite2D.material.get_shader_parameter("noise_texture").noise.seed = seed
		
		if paintable == true:
			var new_specular = Colors.list[color_index][3]
			get_node("Sprite2D").texture.set_specular_shininess(new_specular) #Set the shine level




# ORPHAN NODE HANDLER, DELETE WHEN SCENE CHANGE
func _init():
	Utils.connect("freeing_orphans", Callable(self, "_free_if_orphaned"))
func _free_if_orphaned():
	if not is_inside_tree(): # Optional check - don't free if in the scene tree
		queue_free()
