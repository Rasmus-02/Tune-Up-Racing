extends Node2D

@export_category("ID")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String
@export var Car_ID : int
@export var Part_Number : int
var type = 0 #car or engine
var id = [Car_ID,10,Part_Number,rarity] #Engine ID, Part type, Part number, rank
@export_multiline var description = ""

@export_category("Stats")
@export_range(0 , 10000000) var price : int
@export var weight = 0
@export var drag = 0.0
@export var downforce = 0 #Kg @ 100kmh

var durability = 100 #100%
var color = 0

#For Painting the part
var car
func _ready():
	if get_parent() != null and get_parent().get_parent() != null and get_parent().get_parent().get_parent() != null:
		car = get_parent().get_parent().get_parent().get_parent()
	
func _process(delta):
	if current_color == null or color != current_color:
		print("repaint")
		if car != null and car.is_in_group("Car"):
			paint_part(car.spoiler_color)
		elif get_parent().is_in_group("Computer"):
				paint_part(get_parent().get_parent().get_parent().selected_color)

var current_color = null
func paint_part(color_index):
	var new_material = ShaderMaterial.new()
	var shader = load("res://Shaders/Test/ColorSelector.gdshader")
	new_material.shader = shader
	if $Sprite2D:
		$Sprite2D.material = new_material
		var color = Colors.list[color_index][0]
		current_color = color_index
		$Sprite2D.material.set_shader_parameter("import_new_color", color)
