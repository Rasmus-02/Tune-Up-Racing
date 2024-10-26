extends Node2D
@export_category("ID")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String
@export var Engine_ID : int
@export var Part_Number : int
@export_range(0, 80) var lenght : int
@export_range(0, 80) var width : int
var type = 1 #engine or car
var id = [Engine_ID,1,Part_Number,rarity] #Engine ID, Part type, Part number, rank
@export_multiline var description = ""

@export_category("Stats")
@export var weight = 0
@export var tq_mod = 0.0
@export_category("Turbo")
@export var turbo : bool = false
@export var turbo_efficiency = 1.0
@export_enum("single", "twin", "sequential_twin", "quad", "sequential_quad") var turbo_type : String
@export var sequential_switch_rpm = 0
@export var turbo_1_size = 0.0
@export var turbo_2_size = 0.0
@export var turbo_3_size = 0.0
@export var turbo_4_size = 0.0

var durability = 100 #100%

func get_turbo_max_size():
	match turbo_type:
		"single":
			return turbo_1_size
		"twin":
			return turbo_1_size + turbo_2_size
		"sequential_twin":
			return turbo_1_size
		"quad":
			return turbo_1_size + turbo_2_size + turbo_3_size + turbo_4_size
		"sequential_quad":
			return turbo_1_size + turbo_2_size
