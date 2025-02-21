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
var high_comp_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Internals/PWR SIX-4 High Comp internals.tscn") #2
var low_comp_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Internals/PWR SIX-4 Low Comp Internals.tscn") #3
var forged_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Internals/PWR SIX-4 Forged internals.tscn") #4
var forged_high_comp_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Internals/PWR SIX-4 Forged High Comp internals.tscn") #5
var forged_low_comp_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Internals/PWR SIX-4 Forged Low Comp Internals.tscn") #6
var titanium_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Internals/PWR SIX-4 Titanium internals.tscn") #7
var titanium_high_comp_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Internals/PWR SIX-4 High Comp Titanium internals.tscn") #8
var titanium_low_comp_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Internals/PWR SIX-4 Low Comp Titanium internals.tscn") #9
var internals = [empty, stock_internals, high_comp_internals, low_comp_internals, forged_internals, forged_high_comp_internals, forged_low_comp_internals,
titanium_internals, titanium_high_comp_internals, titanium_low_comp_internals]


#Top
var stock_top = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Top/PWR SIX-4 top.tscn") #1
var vortex_top = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Top/PWR SIX-4 [Vortex] top.tscn") #2
var racing_top = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Top/PWR SIX-4 race top.tscn") #3
var redline_top = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Top/PWR SIX-4 [Redline] top.tscn") #4
var avalon_top = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Top/PWR SIX-4 [Avalon] top.tscn") #5
var top = [empty, stock_top, vortex_top, racing_top, redline_top, avalon_top]


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

