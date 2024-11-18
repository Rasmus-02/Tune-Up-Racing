extends Node2D

@export_category("ID")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String
@export_range(0, 80) var engine_bay_lenght : int
@export_range(0, 80) var engine_bay_width : int
@export_range(0, 120) var engine_bay_start_lenght : int
@export var Car_ID : int
@export var Part_Number : int
var type = 0 #car or engine
var id = [Car_ID,0,Part_Number,rarity] #Engine ID, Part type, Part number, rank
@export_multiline var description = ""

@export_category("Stats")
@export_range(0 , 10000000) var price : int
@export var weight = 0
@export var downforce = 0 #Kg @ 100kmh
@export var drag = 0.0 #drag coeff
@export var wheelbase = 0 #cm

var durability = 100 #100%

func paint_part():
	if $Sprite2D.get_script() != null:
		$Sprite2D.paint(Color(1,0,0,1))
