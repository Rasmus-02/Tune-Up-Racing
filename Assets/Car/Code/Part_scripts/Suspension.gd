extends Node2D

@export_category("ID")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String
var Car_ID = 9999
@export var Part_Number : int
var type = 0 #car or engine
var id = [Car_ID,12,Part_Number,rarity] #Engine ID, Part type, Part number, rank
@export_multiline var description = ""

@export_category("Stats")
@export var weight = 0
@export_range(0.5, 1.5) var handling_bonus #modifier *

var durability = 100 #100%
