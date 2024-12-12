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
var stock_awd_driveshaft = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Driveshaft/Hikari Tasai AWD Driveshaft.tscn") #1
var stock_fwd_driveshaft = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Driveshaft/Hikari Tasai FWD Driveshaft.tscn") #2
var niepa_awd_driveshaft = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Driveshaft/Hikari Tasai [Niepa] AWD Driveshaft.tscn") #3
var redline_awd_driveshaft = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Driveshaft/Hikari Tasai [Redline] Reinforced AWD Driveshaft.tscn") #4
var avalon_awd_driveshaft = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Driveshaft/Hikari Tasai [Avalon] AWD Driveshaft.tscn") #5
var driveshaft = [empty, stock_awd_driveshaft, stock_fwd_driveshaft, niepa_awd_driveshaft, redline_awd_driveshaft, avalon_awd_driveshaft]

#Fenders
var stock_fender = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Fenders/Hikari Tasai Stock Fenders.tscn") #1
var vortex_fender = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Fenders/Hikari Tasai [Vortex] Vented Fenders.tscn") #2
var niepa_fender = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Fenders/Hikari Tasai [Niepa] Widebody Fenders.tscn") #3
var satetsu_fender = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Fenders/Hikari Tasai [Satetsu] Widebody Fenders.tscn") #4
var redline_fender = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Fenders/Hikari Tasai [Redline] Widebody Fenders.tscn") #5
var fenders = [empty, stock_fender, vortex_fender, niepa_fender, satetsu_fender, redline_fender]

#F_bumper
var stock_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/F_bumper/Hikari Tasai Stock Front Bumper.tscn") #1
var facelift_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/F_bumper/Hikari Tasai Facelift Front Bumper.tscn") #2
var niepa_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/F_bumper/Hikari Tasai [Niepa] Front Bumper.tscn") #3
var satetsu_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/F_bumper/Hikari Tasai [Satetsu] Front Bumper.tscn") #4
var avalon_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/F_bumper/Hikari Tasai [Avalon] Front Bumper.tscn") #5
var redline_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/F_bumper/Hikari Tasai [Redline] Front Bumper.tscn") #6
var f_bumper = [empty, stock_front_bumper, facelift_front_bumper, niepa_front_bumper, satetsu_front_bumper, avalon_front_bumper, redline_front_bumper]

#Headlights
var stock_headlights = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Headlights/Hikari Tasai Stock Headlights.tscn") #1
var facelift_headlights = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Headlights/Hikari Tasai Facelift Headlights.tscn") #2
var vortex_headlights = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Headlights/Hikari Tasai [Vortex] Headlights.tscn") #3
var ks_racing_headlights = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Headlights/Hikari Tasai [KS-Racing] Vent Headlights.tscn") #4
var headlights = [empty, stock_headlights, facelift_headlights, vortex_headlights, ks_racing_headlights]

#Hood
var stock_hood = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Hood/Hikari Tasai Stock Hood.tscn") #1
var niepa_hood = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Hood/Hikari Tasai [Niepa] Hood.tscn") #2
var vortex_hood = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Hood/Hikari Tasai [Vortex] Vented Hood.tscn") #3
var ks_racing_carbon_fiber_hood = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Hood/Hikari Tasai [KS-Racing] Carbon Fiber Hood.tscn") #4
var hood = [empty, stock_hood, niepa_hood, vortex_hood, ks_racing_carbon_fiber_hood]

#Mirrors
var stock_mirrors = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Mirrors/Hikari Tasai Stock Mirrors.tscn") #1
var vortex_mirrors = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Mirrors/Hikari Tasai [Vortex] Mirrors.tscn") #2
var avalon_mirrors = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Mirrors/Hikari Tasai [Avalon] Mirrors.tscn") #3
var mirrors = [empty, stock_mirrors, vortex_mirrors, avalon_mirrors]

#R_bumper
var stock_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/R_bumper/Hikari Tasai Stock Rear Bumper.tscn") #1
var facelift_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/R_bumper/Hikari Tasai Facelift Rear Bumper.tscn") #2
var niepa_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/R_bumper/Hikari Tasai [Niepa] Rear Bumper.tscn") #3
var satetsu_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/R_bumper/Hikari Tasai [Satetsu] Rear Bumper.tscn") #4
var redline_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/R_bumper/Hikari Tasai [Redline] Rear Bumper.tscn") #5
var r_bumper = [empty, stock_rear_bumper, facelift_rear_bumper, niepa_rear_bumper, satetsu_rear_bumper, redline_rear_bumper]

#Subframe
var stock_subframe = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Subframe/Hikari Tasai Stock Subframe.tscn") #1
var vortex_subframe = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Subframe/Hikari Tasai [Vortex] Subframe.tscn") #2
var redline_subframe = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Subframe/Hikari Tasai [Redline] Subframe.tscn") #3
var avalon_subframe = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Subframe/Hikari Tasai [Avalon] Subframe.tscn") #4
var subframe = [empty, stock_subframe, vortex_subframe, redline_subframe, avalon_subframe]

#Taillights
var stock_taillights = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Taillights/Hikari Tasai Stock Taillights.tscn") #1
var niepa_taillights = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Taillights/Hikari Tasai [Niepa] Taillights.tscn") #2
var avalon_taillights = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Taillights/Hikari Tasai [Avalon] Taillights.tscn") #3
var redline_taillights = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Taillights/Hikari Tasai [Redline] Taillights.tscn") #4
var satetsu_taillights = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Taillights/Hikari Tasai [Satetsu] Taillights.tscn") #5
var taillights = [empty, stock_taillights, niepa_taillights, avalon_taillights, redline_taillights, satetsu_taillights]

#Spoiler
var niepa_spoiler = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Spoiler/Hikari Tasai [Niepa] Spoiler.tscn") #1
var vortex_spoiler = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Spoiler/Hikari Tasai [Vortex] Spoiler.tscn") #2
var satetsu_spoiler = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Spoiler/Hikari Tasai [Satetsu] Spoiler.tscn") #3
var ks_racing_spoiler = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Spoiler/Hikari Tasai [KS-Racing] Wing.tscn") #4
var avalon_spoiler = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Spoiler/Hikari Tasai [Avalon] Wing.tscn") #5
var spoiler = [empty, niepa_spoiler, vortex_spoiler, satetsu_spoiler, ks_racing_spoiler, avalon_spoiler]

#Exhaust
var stock_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Exhaust/Hikari Tasai Stock Exhaust.tscn") #1
var niepa_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Exhaust/Hikari Tasai [Niepa] Exhaust.tscn") #2
var vortex_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Exhaust/Hikari Tasai [Vortex] Exhaust.tscn") #3
var ks_racing_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Exhaust/Hikari Tasai [KS-Racing] Exhaust.tscn") #4
var redline_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Hikari Tasai/Exhaust/Hikari Tasai [Redline] Exhaust.tscn") #5
var exhaust = [empty, stock_exhaust, niepa_exhaust, vortex_exhaust, ks_racing_exhaust, redline_exhaust]
