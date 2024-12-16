extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")

#Engine ID
var id = 4

#Block
var stock_block = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Block/PWR SIX-4 block.tscn") #1
var block = [empty, stock_block]


#Internals
var stock_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Internals/PWR SIX-4 internals.tscn") #1
var internals = [empty, stock_internals]


#Top
var stock_top = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Top/PWR SIX-4 top.tscn") #1
var top = [empty, stock_top]


#Intake manifold
var stock_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Intake Manifold/PWR SIX-4 intake manifold.tscn") #1
var intake_manifold = [empty, stock_intake_manifold]


#Exhaust manifold
var stock_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/PWR SIX-4/Exhaust Manifold/PWR SIX-4 exhaust manifold.tscn") #1
var exhaust_manifold = [empty, stock_exhaust_manifold]
