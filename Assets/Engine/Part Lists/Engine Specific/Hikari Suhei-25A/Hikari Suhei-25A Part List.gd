extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String

#Engine ID
var id = 3

#Block
var stock_block = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Block/Hikari Suhei-25A stock block.tscn") #1
var aluminium_block = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Block/Hikari Suhei-25A aluminium block.tscn") #2
var heavy_duty_block = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Block/Hikari Suhei-25A heavy duty block.tscn") #3
var avalon_magnesium_block = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Block/Hikari Suhei-25A [Avalon] magnesium block.tscn") #4
var block = [empty, stock_block, aluminium_block, heavy_duty_block, avalon_magnesium_block]


#Internals
var stock_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Internals/Hikari Suhei-25A stock internals.tscn") #1
var stock_high = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Internals/Hikari Suhei-25A high compression internals.tscn") #2
var stock_low = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Internals/Hikari Suhei-25A low compression internals.tscn") #3
var forged = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Internals/Hikari Suhei-25A forged internals.tscn") #4
var forged_high = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Internals/Hikari Suhei-25A forged high compression internals.tscn") #5
var forged_low = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Internals/Hikari Suhei-25A forged low compression internals.tscn") #6
var low_friction = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Internals/Hikari Suhei-25A low friction internals.tscn") #7
var low_friction_high = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Internals/Hikari Suhei-25A low friction high compression internals.tscn") #8
var low_friction_low = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Internals/Hikari Suhei-25A low friction low compression internals.tscn") #9
var titanium = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Internals/Hikari Suhei-25A titanium internals.tscn") #10
var titanium_high = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Internals/Hikari Suhei-25A titanium high compression internals.tscn") #11
var titanium_low = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Internals/Hikari Suhei-25A titanium low compression internals.tscn") #12
var internals = [empty, stock_internals, stock_high, stock_low, forged, forged_high, forged_low,
	low_friction, low_friction_high, low_friction_low, titanium, titanium_high, titanium_low]


#Top
var stock_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Top/Hikari Suhei-25A stock top.tscn") #1
var sport_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Top/Hikari Suhei-25A sport top.tscn") #2
var gt_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Top/Hikari Suhei-25A GT top.tscn") #3
var race_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Top/Hikari Suhei-25A race top.tscn") #4
var redline_race_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Top/Hikari Suhei-25A [Redline] race top.tscn") #5
var avalon_race_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Top/Hikari Suhei-25A [Avalon] race top.tscn") #6
var top = [empty, stock_top, sport_top, gt_top, race_top, redline_race_top, avalon_race_top]


#Intake manifold
var stock_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Intake Manifold/Hikari Suhei-25A stock intake manifold.tscn") #1
var niepa_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Intake Manifold/Hikari Suhei-25A [Niepa] intake manifold.tscn") #2
var vortex_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Intake Manifold/Hikari Suhei-25A [Vortex] intake manifold.tscn") #3
var avalon_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Intake Manifold/Hikari Suhei-25A [Avalon] intake manifold.tscn") #4
var ks_racing_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Intake Manifold/Hikari Suhei-25A [KS-Racing] intake manifold.tscn") #5
var satetsu_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Intake Manifold/Hikari Suhei-25A [Satetsu] intake manifold.tscn") #6
var intake_manifold = [empty, stock_intake_manifold, niepa_intake_manifold, vortex_intake_manifold, avalon_intake_manifold,
	ks_racing_intake_manifold, satetsu_intake_manifold]


#Exhaust manifold
var stock_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Exhaust Manifold/Hikari Suhei-25A stock exhaust manifold.tscn") #1
var vortex_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Exhaust Manifold/Hikari Suhei-25A [Vortex] exhaust manifold.tscn") #2
var ks_racing_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Exhaust Manifold/Hikari Suhei-25A [KS-Racing] exhaust manifold.tscn") #3
var turbo_60mm = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Exhaust Manifold/Hikari Suhei-25A 60mm turbo exhaust manifold.tscn") #4
var redline_turbo_78mm = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Exhaust Manifold/Hikari Suhei-25A [Redline] RT78.tscn") #5
var exhaust_manifold = [empty, stock_exhaust_manifold, vortex_exhaust_manifold, ks_racing_exhaust_manifold, turbo_60mm, redline_turbo_78mm]
