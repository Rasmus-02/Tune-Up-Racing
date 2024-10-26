extends Node

@export_category("ID")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String
@export_range(0, 80) var lenght : int
@export_range(0, 80) var width : int
@export var Engine_ID : int
@export var Part_Number : int
var type = 1 #engine or car
var id = [Engine_ID,3,Part_Number,rarity] #Engine ID, Part type, Part number, rank
@export_multiline var description = ""

@export_category("Stats")
@export var weight = 0
@export var compression = 0.0
@export var max_rpm = 0
@export var max_tq = 0

var durability = 100 #100%
