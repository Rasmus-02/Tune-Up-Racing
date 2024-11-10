extends Node

@export_category("ID")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String
@export var Part_Number : int
@export_range(0, 80) var lenght : int
@export_range(0, 80) var width : int
var Car_ID = 9999
var type = 0 #car or engine
var id = [0,15,Part_Number,rarity] #Engine ID, Part type, Part number, rank
@export_multiline var description = ""

@export_category("Stats")
@export_range(0 , 10000000) var price : int
@export_enum("RWD", "FWD", "AWD") var drivetrain : int #0=RWD, 1=FWD, 2=AWD
@export var weight = 0
@export var shift_time = 0.0
@export var max_hp = 0
@export var max_tq = 0
@export var gear_ratio = [4.0, 3.5, 2.0, 1.5, 1.0, 0.8, 0.65] #Index 0 = final drive

var durability = 100 #100%
