extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String

#Engine ID
var id = 2

#Block
var stock_block = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Block/2S-16i stock block.tscn") #1
var aluminium_block = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Block/2S-16i aluminium block.tscn")#2
var heavy_duty_block = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Block/2S-16i heavy duty block.tscn")#3
var billet_aluminium_block = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Block/2S-16i billet aluminium block.tscn")#4
var block = [empty, stock_block, aluminium_block, heavy_duty_block, billet_aluminium_block]


#Internals
var stock_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Internals/2S-16i stock internals.tscn") #1
var high_stock = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Internals/2S-16i high compression internals.tscn") #2
var low_stock = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Internals/2S-16i low compression internals.tscn") #3
var forged_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Internals/2S-16i forged internals.tscn")#4
var high_forged = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Internals/2S-16i forged high compression internals.tscn")#5
var low_forged = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Internals/2S-16i forged low compression internals.tscn")#6
var low_friction = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Internals/2S-16i low friction internals.tscn")#7
var high_low_friction = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Internals/2S-16i low friction high compression internals.tscn")#8
var low_low_friction = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Internals/2S-16i low friction low compression internals.tscn")#9
var titanium_int = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Internals/2S-16i titanium internals.tscn")#10
var high_titanium = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Internals/2S-16i titanium high compression internals.tscn")#11
var low_titanium = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Internals/2S-16i titanium low compression internals.tscn")#12
var internals = [empty, stock_internals, high_stock, low_stock, forged_internals, high_forged, low_forged, low_friction, high_low_friction, low_low_friction, titanium_int, high_titanium, low_titanium]


#Top
var stock_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Top/2S-16i stock top.tscn") #1
var sport_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Top/2S-16i sport top.tscn") #2
var racing_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Top/2S-16i racing top.tscn") #3
var satesu_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Top/2S-16i [Satesu] racing top.tscn") #4
var stroker_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Top/2S-16i stroker top.tscn")#5
var top = [empty, stock_top, sport_top, racing_top, satesu_top, stroker_top]


#Intake manifold
var stock_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Intake Manifold/2S-16i stock intake manifold.tscn") #1
var ks_racing_supercharger = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Intake Manifold/2S-16i [KS Racing] Supercharger.tscn")#2
var ks_racing_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Intake Manifold/2S-16i [KS Racing] intake manifold.tscn") #3
var vortex_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Intake Manifold/2S-16i [Vortex] intake manifold.tscn") #4
var redline_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Intake Manifold/2S-16i [Redline] intake manifold.tscn") #5
var performance_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Intake Manifold/2S-16i Performance intake manifold.tscn") #6
var intake_manifold = [empty, stock_intake_manifold, ks_racing_supercharger, ks_racing_intake_manifold, vortex_intake_manifold, redline_intake_manifold, performance_intake_manifold]


#Exhaust manifold
var stock_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Exhaust Manifold/2S-16i stock exhaust manifold.tscn") #1
var turbo_66mm_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Exhaust Manifold/2S-16i 66mm turbo exhaust manifold.tscn") #2
var turbokraft_72mm_52mm_sequential_turbo = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Exhaust Manifold/2S-16i [TurboKraft] 72mm + 52mm Sequential Turbos.tscn") #3
var satesu_tubular_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Exhaust Manifold/2S-16i [Satesu] tubular exhaust manifold.tscn") #4
var vortex_vrt50v1 = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Exhaust Manifold/2S-16i [Vortex] VRT50 V1.tscn") #5
var vortex_vrt50v2 = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Exhaust Manifold/2S-16i [Vortex] VRT50 V2.tscn") #6
var redline_rt65 = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Exhaust Manifold/2S-16i [Redline] RT65.tscn")#7
var vortex_performance_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Exhaust Manifold/2S-16i [Vortex] Performance Exhaust Manifold.tscn") #8
var exhaust_manifold = [empty, stock_exhaust_manifold, turbo_66mm_exhaust_manifold, turbokraft_72mm_52mm_sequential_turbo, satesu_tubular_exhaust_manifold, vortex_vrt50v1, vortex_vrt50v2, redline_rt65, vortex_performance_manifold]
