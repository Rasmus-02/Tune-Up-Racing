extends Node2D

@export_category("ID")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String
var Car_ID = 9999
@export var Part_Number : int
var type = 0 #car or engine
var id = [Car_ID,14,Part_Number,rarity] #Engine ID, Part type, Part number, rank
@export_multiline var description = ""

@export_category("Stats")
@export var weight = 0
@export var max_tire_width = 220
@export var brake_cooling = 0.0 #Celcius per second (road: 1-3, race: 2-5)

var durability = 100 #100%
