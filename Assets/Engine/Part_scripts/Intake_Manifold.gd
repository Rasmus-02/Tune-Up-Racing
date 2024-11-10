extends Node2D

@export_category("ID")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String
@export_enum("top", "front") var layout : String
@export_range(-80, 80) var lenght : int
@export_range(0, 80) var width : int
@export var Engine_ID : int
@export var Part_Number : int
var type = 1 #engine or car
var id = [Engine_ID,2,Part_Number,rarity] #Engine ID, Part type, Part number, rank
@export_multiline var description = ""

@export_category("Stats")
@export_range(0 , 10000000) var price : int
@export var weight = 0
@export var tq_mod = 1.0
@export var max_compression_modifier = 1.0
@export var itb = false
@export_category("Supercharger")
@export var supercharger : bool = false
@export var supercharer_displacement_capacity = 0.0


var durability = 100 #100%
