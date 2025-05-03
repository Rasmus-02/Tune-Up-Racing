extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")

#Engine ID
var id = 5

#Block
var stock_block = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Block/Holler DI-2500 cast iron block.tscn") #1
var block = [empty, stock_block]


#Internals
var stock_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Internals/Holler DI-2500 stock internals.tscn") #1
var internals = [empty, stock_internals]


#Top
var stock_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Top/Holler DI-2500 stock top.tscn") #1
var top = [empty, stock_top]


#Intake manifold
var stock_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Intake Manifold/Holler DI-2500 stock intake manifold.tscn") #1
var intake_manifold = [empty, stock_intake_manifold]


#Exhaust manifold
var stock_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Holler DI-2500/Exhaust Manifold/Holler DI-2500 stock exhaust manifold.tscn") #1
var exhaust_manifold = [empty, stock_exhaust_manifold]
