extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")

#Engine ID
var id = 6

#Block
var stock_block = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Shisaku-13S/Block/Hikari Shisaku-13S block.tscn") #1
var block = [empty, stock_block]


#Internals
var stock_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Shisaku-13S/Internals/Hikari Shisaku-13S internals.tscn") #1
var internals = [empty, stock_internals]


#Top
var stock_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Shisaku-13S/Top/Hikari Shisaku-13S top.tscn") #1
var top = [empty, stock_top]


#Intake manifold
var stock_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Shisaku-13S/Intake Manifold/Hikari Shisaku-13S intake manifold.tscn") #1
var intake_manifold = [empty, stock_intake_manifold]


#Exhaust manifold
var stock_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Shisaku-13S/Exhaust Manifold/Hikari Shisaku-13S exhaust manifold.tscn") #1
var exhaust_manifold = [empty, stock_exhaust_manifold]
