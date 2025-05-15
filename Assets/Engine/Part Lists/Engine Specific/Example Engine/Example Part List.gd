extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")

#Engine ID
var id = 5

#Block
var stock_block = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Block/Holler DI-2500 cast iron block.tscn") #1
var aluminium_block = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Block/Holler DI-2500 aluminium block.tscn") #2
var heavy_duty_block = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Block/Holler DI-2500 heavy duty block.tscn") #3
var block = [empty, stock_block, aluminium_block, heavy_duty_block]


#Internals
var stock_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Internals/Holler DI-2500 stock internals.tscn") #1
var high_comp_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Internals/Holler DI-2500 high compression internals.tscn") #2
var low_comp_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Internals/Holler DI-2500 low compression internals.tscn") #3
var forged_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Internals/Holler DI-2500 forged internals.tscn") #4
var forged_high_comp_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Internals/Holler DI-2500 forged high compression internals.tscn") #5
var forged_low_comp_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Internals/Holler DI-2500 forged low compression internals.tscn") #6
var internals = [empty, stock_internals, high_comp_internals, low_comp_internals, forged_internals, forged_high_comp_internals, forged_low_comp_internals]


#Top
var stock_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Top/Holler DI-2500 stock top.tscn") #1
var stroker_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Top/Holler DI-2500 stroker top.tscn") #2
var sport_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Top/Holler DI-2500 sport top.tscn") #3
var vortex_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Top/Holler DI-2500 [Vortex] top.tscn") #4
var top = [empty, stock_top, stroker_top, sport_top, vortex_top]


#Intake manifold
var stock_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Intake Manifold/Holler DI-2500 stock intake manifold.tscn") #1
var performance_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Intake Manifold/Holler DI-2500 performance intake manifold.tscn") #2
var niepa_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Intake Manifold/Holler DI-2500 [Niepa] intake manifold.tscn") #3
var vortex_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Intake Manifold/Holler DI-2500 [Vortex] intake manifold.tscn") #4
var intake_manifold = [empty, stock_intake_manifold, performance_intake_manifold, niepa_intake_manifold, vortex_intake_manifold]


#Exhaust manifold
var stock_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Exhaust Manifold/Holler DI-2500 stock exhaust manifold.tscn") #1
var performance_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Exhaust Manifold/Holler DI-2500 performance exhaust manifold.tscn") #2
var turbo_44mm = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Exhaust Manifold/Holler DI-2500 44mm Turbo.tscn") #3
var vortex_turbo_50mm = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Exhaust Manifold/Holler DI-2500 VT50 Turbo.tscn") #4
var exhaust_manifold = [empty, stock_exhaust_manifold, performance_exhaust_manifold, turbo_44mm, vortex_turbo_50mm]
