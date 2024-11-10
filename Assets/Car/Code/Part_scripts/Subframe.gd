extends Node2D

@export_category("ID")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String
@export var Car_ID : int
@export var Part_Number : int
var type = 0 #car or engine
var id = [Car_ID,8,Part_Number,rarity] #Engine ID, Part type, Part number, rank
@export_multiline var description = ""

@export_category("Stats")
@export_range(0 , 10000000) var price : int
@export var weight = 0

var durability = 100 #100%
