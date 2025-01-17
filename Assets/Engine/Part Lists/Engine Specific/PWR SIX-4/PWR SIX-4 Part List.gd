extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")

#Engine ID
var id = 4

#Block
var stock_block = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Block/PWR SIX-4 block.tscn") #1
var aluminium_block = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Block/PWR SIX-4 aluminium block.tscn") #2
var magnesium_block = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Block/PWR SIX-4 [Avalon] magnesium block.tscn") #3
var block = [empty, stock_block, aluminium_block, magnesium_block]


#Internals
var stock_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Internals/PWR SIX-4 internals.tscn") #1
var internals = [empty, stock_internals]


#Top
var stock_top = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Top/PWR SIX-4 top.tscn") #1
var top = [empty, stock_top]


#Intake manifold
var stock_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Intake Manifold/PWR SIX-4 intake manifold.tscn") #1
var redline_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Intake Manifold/PWR SIX-4 [Redline] intake manifold.tscn") #2
var ks_racing_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Intake Manifold/PWR SIX-4 [KS-Racing] intake manifold.tscn") #3
var avalon_itb_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Intake Manifold/PWR SIX-4 [Avalon] ITB intake manifold.tscn") #4
var satetsu_supercharger = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Intake Manifold/PWR SIX-4 [Satetsu] SSR1800 Supercharger.tscn") #5
var intake_manifold = [empty, stock_intake_manifold, redline_intake_manifold, ks_racing_intake_manifold, 
avalon_itb_intake_manifold, satetsu_supercharger]


#Exhaust manifold
var stock_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Exhaust Manifold/PWR SIX-4 exhaust manifold.tscn") #1
var vortex_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Exhaust Manifold/PWR SIX-4 [Vortex] exhaust manifold.tscn") #2
var redline_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Exhaust Manifold/PWR SIX-4 [Redline] exhaust manifold.tscn") #3
var satetsu_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Exhaust Manifold/PWR SIX-4 [Satetsu] exhaust manifold.tscn") #4
var vortex_VRT70 = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Exhaust Manifold/PWR SIX-4 [Vortex] VRT70 Turbo.tscn") #5
var exhaust_manifold = [empty, stock_exhaust_manifold, vortex_exhaust_manifold, redline_exhaust_manifold, 
satetsu_exhaust_manifold, vortex_VRT70]

