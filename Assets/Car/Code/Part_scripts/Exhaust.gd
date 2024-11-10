extends Node

@export_category("ID")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String
@export var Car_ID : int
@export var Part_Number : int
var type = 0 #car or engine
var id = [Car_ID,17,Part_Number,rarity] #Engine ID, Part type, Part number, rank
@export_multiline var description = ""

@export_category("Stats")
@export_range(0 , 10000000) var price : int
@export var weight = 0
@export_range(0.8, 1.2) var tq_mod = 1.0
@export_range(0.0, 20.0) var sound_dampening = 10 #DB_Dampening
@export_range(0.8, 1.2) var pitch_tweak = 1.0 #DB_Dampening

var durability = 100 #100%
