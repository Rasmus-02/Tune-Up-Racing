extends Node2D

@export_category("ID")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String
@export var Part_Number : int
var Car_ID = 9999
@export_range(0, 80) var width : int
var type = 0 #car or engine
var id = [0,16,Part_Number,rarity] #Engine ID, Part type, Part number, rank
@export_multiline var description = ""

@export_category("Stats")
@export_range(0 , 10000000) var price : int
@export var weight = 0
@export var cooling = 0.0 #degrees / second

var durability = 100 #100%
var color = 0
