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
var stock_rwd_driveshaft = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Driveshaft/Talon Motors Barracuda Driveshaft.tscn") #1
var redline_rwd_driveshaft = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Driveshaft/Talon Motors Barracuda [Redline] Reinforced RWD Driveshaft.tscn") #2
var satetsu_rwd_driveshaft = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Driveshaft/Talon Motors Barracuda [Satetsu] Carbon Fiber RWD Driveshaft.tscn") #3
var driveshaft = [empty, stock_rwd_driveshaft, redline_rwd_driveshaft, satetsu_rwd_driveshaft]

#Fenders
var stock_fender = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Fenders/Talon Motors Barracuda Fenders.tscn") #1
var ks_racing_fender = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Fenders/Talon Motors Barracuda [KS-Racing] Carbon Fiber Fenders.tscn") #2
var niepa_widebody = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Fenders/Talon Motors Barracuda [Niepa] Widebody Fenders.tscn") #3
var satetsu_widebody = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Fenders/Talon Motors Barracuda [Satetsu] Widebody Fenders.tscn") #4
var redline_widebody = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Fenders/Talon Motors Barracuda [Redline] Widebody Fenders.tscn") #5

var fenders = [empty, stock_fender, ks_racing_fender, niepa_widebody, satetsu_widebody, redline_widebody]

#F_bumper
var stock_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/F_bumper/Talon Motors Barracuda Front Bumper.tscn") #1
var facelift_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/F_bumper/Talon Motors Barracuda Facelift Front Bumper.tscn")#2
var vortex_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/F_bumper/Talon Motors Barracuda [Vortex] Front Bumper.tscn")#3
var niepa_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/F_bumper/Talon Motors Barracuda [Niepa] Front Bumper.tscn") #4
var satetsu_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/F_bumper/Talon Motors Barracuda [Satetsu] Front Bumper.tscn") #5
var ks_racing_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/F_bumper/Talon Motors Barracuda [KS-Racing] Front Bumper.tscn") #6
var f_bumper = [empty, stock_front_bumper, facelift_front_bumper, vortex_front_bumper, niepa_front_bumper, satetsu_front_bumper, ks_racing_front_bumper]

#Headlights
var stock_headlights = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Headlights/Talon Motors Barracuda Headlights.tscn") #1
var facelift_headlights = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Headlights/Talon Motors Barracuda Facelift Headlights.tscn") #2
var niepa_headlights = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Headlights/Talon Motors Barracuda [Niepa] Headlights.tscn") #3
var satetsu_headlights = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Headlights/Talon Motors Barracuda [Satetsu] Headlights.tscn") #4
var headlights = [empty, stock_headlights, facelift_headlights, niepa_headlights, satetsu_headlights]

#Hood
var stock_hood = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Hood/Talon Motors Barracuda Hood.tscn") #1
var vortex_hood = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Hood/Talon Motors Barracuda Vortex Hood.tscn") #2
var niepa_hood = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Hood/Talon Motors Barracuda Niepa Hood.tscn") #3
var ks_racing_hood = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Hood/Talon Motors Barracuda KS-Racing Carbon Fiber Hood.tscn") #4
var hood = [empty, stock_hood, vortex_hood, niepa_hood, ks_racing_hood]

#Mirrors
var stock_mirrors = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Mirrors/Talon Motors Barracuda Mirrors.tscn") #1
var niepa_mirrors = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Mirrors/Talon Motors Barracuda [Niepa] Mirrors.tscn") #2
var avalon_mirrors = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Mirrors/Talon Motors Barracuda [Avalon] Mirrors.tscn") #3
var ks_racing_mirrors = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Mirrors/Talon Motors Barracuda [KS-Racing] Carbon Fiber Mirrors.tscn") #4
var mirrors = [empty, stock_mirrors, niepa_mirrors, avalon_mirrors, ks_racing_mirrors]

#R_bumper
var stock_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/R_bumper/Talon Motors Barracuda Rear Bumper.tscn") #1
var facelift_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/R_bumper/Talon Motors Barracuda Facelift Rear Bumper.tscn") #2
var redline_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/R_bumper/Talon Motors Barracuda [Redline] Rear Bumper.tscn") #3
var ks_racing_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/R_bumper/Talon Motors Barracuda [KS-Racing] Rear Bumper.tscn") #4
var r_bumper = [empty, stock_rear_bumper, facelift_rear_bumper, redline_rear_bumper, ks_racing_rear_bumper]

#Subframe
var stock_subframe = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Subframe/Talon Motors Barracuda Subframe.tscn") #1
var vortex_subframe = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Subframe/Talon Motors Barracuda [Vortex] Subframe.tscn") #2
var redline_subframe = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Subframe/Talon Motors Barracuda [Redline] Subframe.tscn") #3
var satetsu_subframe = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Subframe/Talon Motors Barracuda [Satetsu] Subframe.tscn") #4
var subframe = [empty, stock_subframe, vortex_subframe, redline_subframe, satetsu_subframe]

#Taillights
var stock_taillights = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Taillights/Talon Motors Barracuda Taillights.tscn") #1
var facelift_taillights = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Taillights/Talon Motors Barracuda Facelift Taillights.tscn") #2
var niepa_taillights = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Taillights/Talon Motors Barracuda [Niepa] Taillights.tscn") #3
var satetsu_taillights = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Taillights/Talon Motors Barracuda [Satetsu] Taillights.tscn") #4
var taillights = [empty, stock_taillights, facelift_taillights, niepa_taillights, satetsu_taillights]

#Spoiler
var satetsu_spoiler = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Spoiler/Talon Motors Barracuda [Satetsu] Spoiler.tscn") #1
var niepa_spoiler = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Spoiler/Talon Motors Barracuda [Niepa] Spoiler.tscn") #2
var vortex_spoiler = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Spoiler/Talon Motors Barracuda [Vortex] Spoiler.tscn") #3
var ks_racing_wing = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Spoiler/Talon Motors Barracuda [KS-Racing] Wing.tscn") #4
var avalon_wing = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Spoiler/Talon Motors Barracuda [Avalon] Wing.tscn") #4
var spoiler = [empty, satetsu_spoiler, niepa_spoiler, vortex_spoiler, ks_racing_wing, avalon_wing]

#Exhaust
var stock_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Exhaust/Talon Motors Barracuda Exhaust.tscn") #1
var vortex_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Exhaust/Talon Motors Barracuda [Vortex] Exhaust.tscn") #2
var niepa_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Exhaust/Talon Motors Barracuda [Niepa] Exhaust.tscn") #3
var redline_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Exhaust/Talon Motors Barracuda [Redline] Exhaust.tscn") #4
var avalon_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Talon Motors Barracuda/Exhaust/Talon Motors Barracuda [Avalon] Exhaust.tscn") #5
var exhaust = [empty, stock_exhaust, vortex_exhaust, niepa_exhaust, redline_exhaust, avalon_exhaust]
