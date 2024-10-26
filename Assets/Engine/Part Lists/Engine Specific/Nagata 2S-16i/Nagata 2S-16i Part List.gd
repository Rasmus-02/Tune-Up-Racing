extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String

#Engine ID
var id = 2

#Block
var stock_block = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Block/2S-16i stock block.tscn") #1
var block = [empty, stock_block]


#Internals
var stock_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Internals/2S-16i stock internals.tscn") #1
var high_stock = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Internals/2S-16i high compression internals.tscn") #2
var low_stock = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Internals/2S-16i low compression internals.tscn") #3
var internals = [empty, stock_internals, high_stock, low_stock]


#Top
var stock_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Top/2S-16i stock top.tscn") #1
var sport_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Top/2S-16i sport top.tscn") #2
var racing_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Top/2S-16i racing top.tscn") #3
var satesu_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Top/2S-16i [Satesu] racing top.tscn") #4
var top = [empty, stock_top, sport_top, racing_top, satesu_top]


#Intake manifold
var stock_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Intake Manifold/2S-16i stock intake manifold.tscn") #1
var ks_racing_supercharger = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Intake Manifold/2S-16i [KS Racing] Supercharger.tscn")#2
var ks_racing_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Intake Manifold/2S-16i [KS Racing] intake manifold.tscn") #3
var intake_manifold = [empty, stock_intake_manifold, ks_racing_supercharger, ks_racing_intake_manifold]


#Exhaust manifold
var stock_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Exhaust Manifold/2S-16i stock exhaust manifold.tscn") #1
var turbo_66mm_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Exhaust Manifold/2S-16i 66mm turbo exhaust manifold.tscn") #2
var turbokraft_72mm_52mm_sequential_turbo = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Exhaust Manifold/2S-16i [TurboKraft] 72mm + 52mm Sequential Turbos.tscn") #3
var satesu_tubular_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Exhaust Manifold/2S-16i [Satesu] tubular exhaust manifold.tscn") #4
var exhaust_manifold = [empty, stock_exhaust_manifold, turbo_66mm_exhaust_manifold, turbokraft_72mm_52mm_sequential_turbo, satesu_tubular_exhaust_manifold]
