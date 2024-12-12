extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String

#Air Filter
var stock_air_filter_2s16i = preload("res://Assets/Engine/Part Lists/Universal/Air Filter/Front/2S-16i stock intake.tscn") #0
var cold_air_filter = preload("res://Assets/Engine/Part Lists/Universal/Air Filter/Front/Cold air intake.tscn") #1
var round_carb_filter = preload("res://Assets/Engine/Part Lists/Universal/Air Filter/Top/Round Top Mount Intake.tscn")
var air_filter = [empty, stock_air_filter_2s16i, cold_air_filter, round_carb_filter]


# ORPHAN NODE HANDLER, DELETE WHEN SCENE CHANGE
func _init():
	Utils.connect("freeing_orphans", Callable(self, "_free_if_orphaned"))
func _free_if_orphaned():
	if not is_inside_tree(): # Optional check - don't free if in the scene tree
		queue_free()
