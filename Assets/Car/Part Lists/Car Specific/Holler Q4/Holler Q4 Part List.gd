extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String

#Car ID
var id = 4
var stock_engine = 5

#Chassi
var q4_chassi = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Chassi/Holler Q4 Chassi.tscn") #1
var chassi = [q4_chassi]

#Driveshaft
var stock_awd_driveshaft = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Driveshaft/Holler Q4 Stock AWD Driveshaft.tscn") #1
var driveshaft = [empty, stock_awd_driveshaft]

#Fenders
var stock_fender = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Fenders/Holler Q4 Stock Fenders.tscn") #1
var fenders = [empty, stock_fender]

#F_bumper
var stock_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/F_bumper/Holler Q4 Stock Front Bumper.tscn") #1
var f_bumper = [empty, stock_front_bumper]

#Headlights
var stock_headlights = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Headlights/Holler Q4 Stock Headlights.tscn") #1
var headlights = [empty, stock_headlights]

#Hood
var stock_hood = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Hood/Holler Q4 Stock Hood.tscn") #1
var hood = [empty, stock_hood]

#Mirrors
var stock_mirrors = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Mirrors/Holler Q4 Stock Mirrors.tscn") #1
var mirrors = [empty, stock_mirrors]

#R_bumper
var stock_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/R_bumper/Holler Q4 Stock Rear Bumper.tscn") #1
var r_bumper = [empty, stock_rear_bumper]

#Subframe
var stock_subframe = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Subframe/Holler Q4 Stock Subframe.tscn") #1
var subframe = [empty, stock_subframe]

#Taillights
var stock_taillights = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Taillights/Holler Q4 Stock Taillights.tscn") #1
var taillights = [empty, stock_taillights]

#Spoiler
var spoiler = [empty]

#Exhaust
var stock_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Exhaust/Holler Q4 Stock Exhaust.tscn") #1
var exhaust = [empty, stock_exhaust]
