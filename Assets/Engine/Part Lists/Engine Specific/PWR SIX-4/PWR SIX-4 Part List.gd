extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")

#Engine ID
var id = 0

#Block
var stock_block = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Block/2S-16i stock block.tscn") #0
var block = [empty, stock_block]


#Internals
var stock_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Internals/2S-16i stock internals.tscn") #0
var internals = [empty, stock_internals]


#Top
var stock_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Top/2S-16i stock top.tscn") #0
var sport_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Top/2S-16i sport top.tscn") #1
var top = [empty, stock_top, sport_top]


#Intake manifold
var stock_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Intake Manifold/2S-16i stock intake manifold.tscn") #0
var intake_manifold = [empty, stock_intake_manifold]


#Exhaust manifold
var stock_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Exhaust Manifold/2S-16i stock exhaust manifold.tscn") #0
var exhaust_manifold = [empty, stock_exhaust_manifold]


#Radiator
var stock_radiator = preload("res://Assets/Engine/Part Lists/Engine Specific/Nagata 2S-16i/Radiator/2S16i stock radiator.tscn") #0
var radiator = [empty, stock_radiator]
