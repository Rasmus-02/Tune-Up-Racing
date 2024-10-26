extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String

#Engine ID
var id = 1

#Block
var stock_block = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Block/Typhoon cast iron block.tscn") #1
var block = [empty, stock_block]


#Internals
var stock_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Internals/Typhoon Stock internals.tscn") #1
var stock_high = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Internals/Typhoon high compression internals.tscn")
var stock_low = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Internals/Typhoon low compression internals.tscn")
var internals = [empty, stock_internals, stock_high, stock_low]


#Top
var stock_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Top/Typhoon stock top.tscn") #1
var sport_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Top/Typhoon sport top.tscn") #2
var top = [empty, stock_top, sport_top]


#Intake manifold
var stock_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Intake Manifold/Typhoon Stock intake manifold.tscn") #1
var redline_supercharger = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Intake Manifold/Typhoon [Redline] Supercharger intake manifold.tscn") #2
var efi_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Intake Manifold/Typhoon EFI intake manifold.tscn")#3
var intake_manifold = [empty, stock_intake_manifold, redline_supercharger, efi_intake_manifold]


#Exhaust manifold
var stock_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Exhaust Manifold/Typhoon stock exhaust manifold.tscn") #1
var vortex_60mm_twin_turbo = preload("res://Assets/Engine/Part Lists/Engine Specific/Talon Motors Typhoon/Exhaust Manifold/Typhoon [Vortex] 60mm twin turbo.tscn") #2
var exhaust_manifold = [empty, stock_exhaust_manifold, vortex_60mm_twin_turbo]


