extends Node2D

@export_category("ID")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String
var Car_ID = 9999
@export var Part_Number : int
var type = 0 #car or engine
var id = [Car_ID,11,Part_Number,rarity] #Engine ID, Part type, Part number, rank
@export_multiline var description = ""

@export_category("Stats")
@export_range(0 , 10000000) var price : int
@export var weight = 0
@export var brake_force = 0
@export var brake_cooling = 0.0 #Celcius per second (road: 1-3, race: 2-5)
@export var brake_fade_limit = 0 #Degrees celcius

var durability = 100 #100%
