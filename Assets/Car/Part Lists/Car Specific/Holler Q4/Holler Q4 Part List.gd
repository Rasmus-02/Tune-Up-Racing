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
var vortex_awd_driveshaft = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Driveshaft/Holler Q4 [Vortex] AWD Driveshaft.tscn") #2
var driveshaft = [empty, stock_awd_driveshaft, vortex_awd_driveshaft]

#Fenders
var stock_fender = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Fenders/Holler Q4 Stock Fenders.tscn") #1
var niepa_fender = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Fenders/Holler Q4 [Niepa] Fenders.tscn") #2
var ks_racing_fender = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Fenders/Holler Q4 [KS-Racing] Carbon Fiber Fenders.tscn") #3
var vortex_fender = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Fenders/Holler Q4 [Vortex] Widebody Fenders.tscn") #4
var fenders = [empty, stock_fender, niepa_fender, ks_racing_fender, vortex_fender]

#F_bumper
var stock_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/F_bumper/Holler Q4 Stock Front Bumper.tscn") #1
var makeshift_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/F_bumper/Holler Q4 Makeshift Front Bumper.tscn") #2
var facelift_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/F_bumper/Holler Q4 Facelift Front Bumper.tscn") #3
var vortex_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/F_bumper/Holler Q4 [Vortex] Front Bumper.tscn") #4
var satetsu_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/F_bumper/Holler Q4 [Satetsu] Front Bumper.tscn") #5
var f_bumper = [empty, stock_front_bumper, makeshift_front_bumper, facelift_front_bumper, vortex_front_bumper, satetsu_front_bumper]

#Headlights
var stock_headlights = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Headlights/Holler Q4 Stock Headlights.tscn") #1
var facelift_headlights = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Headlights/Holler Q4 Facelift Headlights.tscn") #2
var niepa_headlights = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Headlights/Holler Q4 [Niepa] Headlights.tscn") #3
var satetsu_headlights = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Headlights/Holler Q4 [Satetsu] Headlights.tscn") #4
var headlights = [empty, stock_headlights, facelift_headlights, niepa_headlights, satetsu_headlights]

#Hood
var stock_hood = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Hood/Holler Q4 Stock Hood.tscn") #1
var vortex_hood = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Hood/Holler Q4 [Vortex] Vented Hood.tscn") #2
var ks_racing_hood = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Hood/Holler Q4 [KS-Racing] Carbon Fiber Hood.tscn") #3
var hood = [empty, stock_hood, vortex_hood, ks_racing_hood]

#Mirrors
var stock_mirrors = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Mirrors/Holler Q4 Stock Mirrors.tscn") #1
var facelift_mirrors = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Mirrors/Holler Q4 Facelift Mirrors.tscn") #2
var ks_racing_mirrors = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Mirrors/Holler Q4 [KS-Racing] Mirrors.tscn") #3
var mirrors = [empty, stock_mirrors]

#R_bumper
var stock_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/R_bumper/Holler Q4 Stock Rear Bumper.tscn") #1
var facelift_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/R_bumper/Holler Q4 Facelift Rear Bumper.tscn") #2
var niepa_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/R_bumper/Holler Q4 [Niepa] Rear Bumper.tscn") #3
var vortex_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/R_bumper/Holler Q4 [Vortex] Rear Bumper.tscn") #4
var r_bumper = [empty, stock_rear_bumper, facelift_rear_bumper, niepa_rear_bumper, vortex_rear_bumper]

#Subframe
var stock_subframe = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Subframe/Holler Q4 Stock Subframe.tscn") #1
var niepa_subframe = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Subframe/Holler Q4 [Niepa] Subframe.tscn") #2
var vortex_subframe = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Subframe/Holler Q4 [Vortex] Subframe.tscn") #3
var subframe = [empty, stock_subframe, niepa_subframe, vortex_subframe]

#Taillights
var stock_taillights = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Taillights/Holler Q4 Stock Taillights.tscn") #1
var facelift_taillights = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Taillights/Holler Q4 Facelift Taillights.tscn") #2
var niepa_taillights = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Taillights/Holler Q4 [Niepa] Taillights.tscn") #3
var taillights = [empty, stock_taillights, facelift_taillights, niepa_taillights]

#Spoiler
var makeshift_spoiler = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Spoiler/Holler Q4 Makeshift Spoiler.tscn")
var vortex_spoiler = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Spoiler/Holler Q4 [Vortex] Spoiler.tscn")
var spoiler = [empty, makeshift_spoiler, vortex_spoiler]

#Exhaust
var stock_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Exhaust/Holler Q4 Stock Exhaust.tscn") #1
var facelift_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Exhaust/Holler Q4 Facelift Exhaust.tscn") #2
var niepa_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Exhaust/Holler Q4 [Niepa] Exhaust.tscn") #3
var vortex_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Exhaust/Holler Q4 [Vortex] Exhaust.tscn") #4
var ks_racing_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Holler Q4/Exhaust/Holler Q4 [KS-Racing] Exhaust.tscn") #5
var exhaust = [empty, stock_exhaust, facelift_exhaust, niepa_exhaust, vortex_exhaust, ks_racing_exhaust]
