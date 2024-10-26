extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String
#Car ID
var id = 1
var stock_engine = 1

#Chassi
var koi_chassi = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Chassi/Talon Motors Barracuda Chassi.tscn") #0
var chassi = [koi_chassi]

#Driveshaft
var stock_rwd_driveshaft = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Driveshaft/Talon Motors Barracuda Driveshaft.tscn")
var driveshaft = [empty, stock_rwd_driveshaft]

#Fenders
var stock_fender = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Fenders/Talon Motors Barracuda Fenders.tscn") #1
var satetsu_widebody = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Fenders/Talon Motors Barracuda [Satetsu] Widebody Fenders.tscn") #2
var fenders = [empty, stock_fender, satetsu_widebody]

#F_bumper
var stock_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/F_bumper/Talon Motors Barracuda Front Bumper.tscn") #1
var vortex_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/F_bumper/Talon Motors Barracuda [Vortex] Front Bumper.tscn")#2
var satetsu_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/F_bumper/Talon Motors Barracuda [Satetsu] Front Bumper.tscn") #3
var f_bumper = [empty, stock_front_bumper, vortex_front_bumper, satetsu_front_bumper]

#Headlights
var stock_headlights = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Headlights/Talon Motors Barracuda Headlights.tscn")
var headlights = [empty, stock_headlights]

#Hood
var stock_hood = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Hood/Talon Motors Barracuda Hood.tscn") #1
var vortex_hood = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Hood/Talon Motors Barracuda Vortex Hood.tscn") #2
var hood = [empty, stock_hood, vortex_hood]

#Mirrors
var stock_mirrors = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Mirrors/Talon Motors Barracuda Mirrors.tscn")
var mirrors = [empty, stock_mirrors]

#R_bumper
var stock_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/R_bumper/Talon Motors Barracuda Rear Bumper.tscn")
var r_bumper = [empty, stock_rear_bumper]

#Subframe
var stock_subframe = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Subframe/Talon Motors Barracuda Subframe.tscn")
var subframe = [empty, stock_subframe]

#Taillights
var stock_taillights = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Taillights/Talon Motors Barracuda Taillights.tscn")
var taillights = [empty, stock_taillights]

#Spoiler
var satetsu_spoiler = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Spoiler/Talon Motors Barracuda [Satetsu] Spoiler.tscn") #1
var spoiler = [empty, satetsu_spoiler]

#Exhaust
var stock_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Exhaust/Talon Motors Barracuda Exhaust.tscn")
var exhaust = [empty, stock_exhaust]
