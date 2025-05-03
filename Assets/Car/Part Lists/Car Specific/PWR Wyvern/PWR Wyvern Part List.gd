extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String

#Car ID
var id = 3
var stock_engine = 4

#Chassi
var wyvern_chassi = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Chassi/PWR Wyvern Chassi.tscn") #1
var chassi = [wyvern_chassi]

#Driveshaft
var stock_rwd_driveshaft = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Driveshaft/PWR Wyvern Driveshaft.tscn") #1
var redline_rwd_driveshaft = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Driveshaft/PWR Wyvern [Redline] Reinforced Driveshaft.tscn") #2
var driveshaft = [empty, stock_rwd_driveshaft, redline_rwd_driveshaft]

#Fenders
var stock_fender = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Fenders/PWR Wyvern Fenders.tscn") #1
var ks_racing_fender = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Fenders/PWR Wyvern [KS-Racing] Carbon Fiber Fenders.tscn") #2
var satetsu_fender = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Fenders/PWR Wyvern [Satetsu] Widebody Fenders.tscn") #3
var redline_fender = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Fenders/PWR Wyvern [Redline] Widebody Fenders.tscn") #4
var fenders = [empty, stock_fender, ks_racing_fender, satetsu_fender, redline_fender]

#F_bumper
var stock_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/F_bumper/PWR Wyvern Front Bumper.tscn") #1
var vortex_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/F_bumper/PWR Wyvern [Vortex] Front Bumper.tscn") #2
var satetsu_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/F_bumper/PWR Wyvern [Satetsu] Front Bumper.tscn") #3
var ks_racing_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/F_bumper/PWR Wyvern [KS-Racing] Front Bumper.tscn") #4
var f_bumper = [empty, stock_front_bumper, vortex_front_bumper, satetsu_front_bumper, ks_racing_front_bumper]

#Headlights
var stock_headlights = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Headlights/PWR Wyvern Headlights.tscn") #1
var satetsu_headlights = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Headlights/PWR Wyvern [Satetsu] Headlights.tscn") #2
var redline_headlights = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Headlights/PWR Wyvern [Redline] Headlights.tscn") #3
var ks_racing_headlights = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Headlights/PWR Wyvern [KS-Racing] Headlights.tscn") #4
var headlights = [empty, stock_headlights, satetsu_headlights, redline_headlights, ks_racing_headlights]

#Hood
var stock_hood = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Hood/PWR Wyvern Hood.tscn") #1
var vortex_hood = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Hood/PWR Wyvern [Vortex] Vented Hood.tscn") #2
var ks_racing_hood = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Hood/PWR Wyvern [KS-Racing] Carbon Fiber Hood.tscn") #3
var redline_hood = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Hood/PWR Wyvern [Redline] Vented Hood.tscn") #4
var hood = [empty, stock_hood, vortex_hood, ks_racing_hood, redline_hood]

#Mirrors
var stock_mirrors = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Mirrors/PWR Wyvern Mirrors.tscn") #1
var vortex_mirrors = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Mirrors/PWR Wyvern [Vortex] Mirrors.tscn") #2
var mirrors = [empty, stock_mirrors, vortex_mirrors]

#R_bumper
var stock_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/R_bumper/PWR Wyvern Rear Bumper.tscn") #1
var vortex_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/R_bumper/PWR Wyvern [Vortex] Rear Bumper.tscn") #2
var ks_racing_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/R_bumper/PWR Wyvern [KS-Racing] Rear Bumper.tscn") #3
var r_bumper = [empty, stock_rear_bumper, vortex_rear_bumper, ks_racing_rear_bumper]

#Subframe
var stock_subframe = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Subframe/PWR Wyvern Subframe.tscn") #1
var satetsu_subframe = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Subframe/PWR Wyvern [Satetsu] Lightweight Subframe.tscn") #2
var subframe = [empty, stock_subframe, satetsu_subframe]

#Taillights
var stock_taillights = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Taillights/PWR Wyvern Taillights.tscn") #1
var satetsu_taillights = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Taillights/PWR Wyvern [Satetsu] Taillights.tscn") #2
var taillights = [empty, stock_taillights, satetsu_taillights]

#Spoiler
var vortex_spoiler = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Spoiler/PWR Wyvern [Vortex] Spoiler.tscn") #1
var satetsu_spoiler = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Spoiler/PWR Wyvern [Satetsu] Wing.tscn") #2
var ks_racing_spoiler = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Spoiler/PWR Wyvern [KS-Racing] Carbon Fiber Wing.tscn") #3
var spoiler = [empty, vortex_spoiler, satetsu_spoiler, ks_racing_spoiler]

#Exhaust
var stock_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Exhaust/PWR Wyvern Exhaust.tscn") #1
var vortex_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Exhaust/PWR Wyvern [Vortex] Exhaust.tscn") #2
var redline_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Exhaust/PWR Wyvern [Redline] Exhaust.tscn") #3
var avalon_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/PWR Wyvern/Exhaust/PWR Wyvern [Avalon] Exhaust.tscn") #4
var exhaust = [empty, stock_exhaust, vortex_exhaust, redline_exhaust, avalon_exhaust]
