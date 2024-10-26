extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String

#Engine ID
var id = 3

#Block
var stock_block = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Block/Hikari Suhei-25A stock block.tscn") #1
var block = [empty, stock_block]


#Internals
var stock_internals = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Internals/Hikari Suhei-25A stock internals.tscn") #1
var stock_high = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Internals/Hikari Suhei-25A high compression internals.tscn") #2
var stock_low = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Internals/Hikari Suhei-25A low compression internals.tscn") #3
var internals = [empty, stock_internals, stock_high, stock_low]


#Top
var stock_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Top/Hikari Suhei-25A stock top.tscn") #1
var sport_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Top/Hikari Suhei-25A sport top.tscn") #2
var race_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Top/Hikari Suhei-25A race top.tscn") #3
var avalon_race_top = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Top/Hikari Suhei-25A [Avalon] race top.tscn") #4
var top = [empty, stock_top, sport_top, race_top, avalon_race_top]


#Intake manifold
var stock_intake_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Intake Manifold/Hikari Suhei-25A stock intake manifold.tscn") #1
var intake_manifold = [empty, stock_intake_manifold]


#Exhaust manifold
var stock_exhaust_manifold = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Exhaust Manifold/Hikari Suhei-25A stock exhaust manifold.tscn") #1
var turbo_60mm = preload("res://Assets/Engine/Part Lists/Engine Specific/Hikari Suhei-25A/Exhaust Manifold/Hikari Suhei-25A 60mm turbo exhaust manifold.tscn")
var exhaust_manifold = [empty, stock_exhaust_manifold, turbo_60mm]
