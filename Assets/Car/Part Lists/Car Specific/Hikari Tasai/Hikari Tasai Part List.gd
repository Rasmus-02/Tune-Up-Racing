extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String
#Car ID
var id = 2
var stock_engine = 3

#Chassi
var tasai_chassi = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Chassi/Hikari Tasai Chassi.tscn") #0
var chassi = [tasai_chassi]

#Driveshaft
var stock_awd_driveshaft = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Driveshaft/Hikari Tasai AWD Driveshaft.tscn") #0
var driveshaft = [empty, stock_awd_driveshaft]

#Fenders
var stock_fender = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Fenders/Hikari Tasai Stock Fenders.tscn") #0
var fenders = [empty, stock_fender]

#F_bumper
var stock_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/F_bumper/Hikari Tasai Stock Front Bumper.tscn") #0
var f_bumper = [empty, stock_front_bumper]

#Headlights
var stock_headlights = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Headlights/Hikari Tasai Stock Headlights.tscn")
var headlights = [empty, stock_headlights]

#Hood
var stock_hood = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Hood/Hikari Tasai Stock Hood.tscn") #1
var ks_racing_carbon_fiber_hood = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Hood/Hikari Tasai [KS-Racing] Carbon Fiber Hood.tscn") #2
var hood = [empty, stock_hood, ks_racing_carbon_fiber_hood]

#Mirrors
var stock_mirrors = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Mirrors/Hikari Tasai Stock Mirrors.tscn")
var mirrors = [empty, stock_mirrors]

#R_bumper
var stock_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/R_bumper/Hikari Tasai Stock Rear Bumper.tscn")
var r_bumper = [empty, stock_rear_bumper]

#Subframe
var stock_subframe = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Subframe/Hikari Tasai Stock Subframe.tscn")
var subframe = [empty, stock_subframe]

#Taillights
var stock_taillights = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Taillights/Hikari Tasai Stock Taillights.tscn")
var taillights = [empty, stock_taillights]

#Windows
var spoiler = [empty]

#Exhaust
var stock_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Exhaust/Hikari Tasai Stock Exhaust.tscn")
var exhaust = [empty, stock_exhaust]
