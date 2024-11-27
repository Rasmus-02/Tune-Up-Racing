extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String
#Car ID
var id = 0
var stock_engine = 2

#Chassi
var koi_chassi = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Chassi/Nagata Koi Chassi.tscn") #0
var chassi = [koi_chassi]

#Driveshaft
var stock_fwd_driveshaft = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Driveshaft/Nagata Koi Stock FWD Driveshaft.tscn") #0
var driveshaft = [empty, stock_fwd_driveshaft]

#Fenders
var stock_fender = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Fenders/Nagata Koi Stock Fenders.tscn") #1
var vortex_widebody = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Fenders/Nagata Koi [Vortex] Widebody Fenders.tscn") #2
var satetsu_widebody = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Fenders/Nagata Koi [Satetsu] Widebody Fenders.tscn") #3
var fenders = [empty, stock_fender, vortex_widebody, satetsu_widebody]

#F_bumper
var stock_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/F_bumper/Nagata Koi Stock Front Bumper.tscn") #1
var ks_racing_timeattack_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/F_bumper/Nagata Koi [KS-Racing] Timeattack Front Bumper.tscn") #2
var satetsu_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/F_bumper/Nagata Koi [Satetsu] Front Bumper.tscn") #3
var vortex_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/F_bumper/Nagata Koi [Vortex] Front Bumper.tscn") #4
var redline_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/F_bumper/Nagata Koi [Redline] Front Bumper.tscn") #5
var f_bumper = [empty, stock_front_bumper, ks_racing_timeattack_front_bumper, satetsu_front_bumper, vortex_front_bumper, redline_front_bumper]

#Headlights
var stock_headlights = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Headlights/Nagata Koi Stock Headlights.tscn") #1
var headlights = [empty, stock_headlights]

#Hood
var stock_hood = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Hood/Nagata Koi Stock Hood.tscn") #1
var vortex_vented_hood = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Hood/Nagata Koi [Vortex] Vented Hood.tscn") #2
var ks_racing_carbon_hood = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Hood/Nagata Koi [KS-Racing] Carbon Fiber Hood.tscn") #3
var satetsu_vented_hood = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Hood/Nagata Koi [Satetsu] Vented Hood.tscn") #4
var redline_carbon_hood = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Hood/Nagata Koi [Redline] Vented Carbon Fiber Hood.tscn") #5
var hood = [empty, stock_hood, vortex_vented_hood, ks_racing_carbon_hood, satetsu_vented_hood, redline_carbon_hood]

#Mirrors
var stock_mirrors = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Mirrors/Nagat Koi Stock Mirrors.tscn")#1
var mirrors = [empty, stock_mirrors]

#R_bumper
var stock_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/R_bumper/Nagata Koi Stock Rear Bumper.tscn")#1
var satetsu_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/R_bumper/Nagata Koi [Satetsu] Rear Bumper.tscn") #2
var r_bumper = [empty, stock_rear_bumper, satetsu_rear_bumper]

#Subframe
var stock_subframe = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Subframe/Nagata Koi Stock Subframe.tscn")#1
var subframe = [empty, stock_subframe]

#Taillights
var stock_taillights = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Taillights/Nagata Koi Stock Taillights.tscn")#1
var taillights = [empty, stock_taillights]

#Windows
var roof_spoiler = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Spoiler/Nagata Koi Factory Roof Spoiler.tscn")#1
var ks_racing_wing = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Spoiler/Nagata Koi [KS-Racing] Carbon Fiber Wing.tscn") #2
var spoiler = [empty, roof_spoiler, ks_racing_wing]

#Exhaust
var stock_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Exhaust/Nagata Koi Stock Exhaust.tscn")#1
var vortex_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Exhaust/Nagata Koi [Vortex] Exhaust.tscn")#2
var exhaust = [empty, stock_exhaust, vortex_exhaust]
