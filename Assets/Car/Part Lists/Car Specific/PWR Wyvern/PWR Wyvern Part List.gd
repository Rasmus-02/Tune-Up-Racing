extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String

#Car ID
var id = 3
var stock_engine = 4

#Chassi
var wyvern_chassi = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Chassi/PWR Wyvern Chassi.tscn") #0
var chassi = [wyvern_chassi]

#Driveshaft
var stock_rwd_driveshaft = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Driveshaft/PWR Wyvern Driveshaft.tscn") #0
var driveshaft = [empty, stock_rwd_driveshaft]

#Fenders
var stock_fender = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Fenders/PWR Wyvern Fenders.tscn") #0
var fenders = [empty, stock_fender]

#F_bumper
var stock_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/F_bumper/PWR Wyvern Front Bumper.tscn") #0
var f_bumper = [empty, stock_front_bumper]

#Headlights
var stock_headlights = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Headlights/PWR Wyvern Headlights.tscn")
var headlights = [empty, stock_headlights]

#Hood
var stock_hood = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Hood/PWR Wyvern Hood.tscn")
var hood = [empty, stock_hood]

#Mirrors
var stock_mirrors = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Mirrors/PWR Wyvern Mirrors.tscn")
var mirrors = [empty, stock_mirrors]

#R_bumper
var stock_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/R_bumper/PWR Wyvern Rear Bumper.tscn")
var r_bumper = [empty, stock_rear_bumper]

#Subframe
var stock_subframe = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Subframe/PWR Wyvern Subframe.tscn")
var subframe = [empty, stock_subframe]

#Taillights
var stock_taillights = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Taillights/PWR Wyvern Taillights.tscn")
var taillights = [empty, stock_taillights]

#Spoiler
var spoiler = [empty]

#Exhaust
var stock_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Exhaust/PWR Wyvern Exhaust.tscn")
var exhaust = [empty, stock_exhaust]
