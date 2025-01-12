extends Node2D

@export_category("ID")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String
@export_enum("Iron", "Aluminium", "Magnesium", "Titanium", "Plasitc", "Carbon Fiber", "Rubber") var part_material : int = 4
@export_enum("top", "front") var layout : String
@export var Part_Number : int
@export_range(0, 80) var lenght : int
@export_range(0, 80) var width : int
var Engine_ID = 9999
var type = 1 #engine or car
var id = [0,5,Part_Number,rarity] #Engine ID, Part type, Part number, rank
@export_multiline var description = ""

@export_category("Stats")
@export_range(0 , 10000000) var price : int
@export var weight = 0
@export_range(0.5, 1.5) var tq_mod
@export_range(-5,5, 0.1) var intake_db_mod

var durability = 100 #100%
var color = 0



# ORPHAN NODE HANDLER, DELETE WHEN SCENE CHANGE
func _init():
	Utils.connect("freeing_orphans", Callable(self, "_free_if_orphaned"))
func _free_if_orphaned():
	if not is_inside_tree(): # Optional check - don't free if in the scene tree
		queue_free()
