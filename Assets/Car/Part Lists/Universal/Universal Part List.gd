extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String

#Brakes
var basic_road_brakes = preload("res://Assets/Car/Part Lists/Universal/Brakes/Basic Road Brakes.tscn") #1
var basic_sport_brakes = preload("res://Assets/Car/Part Lists/Universal/Brakes/Basic Sport Brakes.tscn") #2
var brakes = [empty, basic_road_brakes, basic_sport_brakes]

#Suspension
var soft_road_suspension = preload("res://Assets/Car/Part Lists/Universal/Suspension/Soft Road Suspension.tscn") #1
var vortex_sport_suspension = preload("res://Assets/Car/Part Lists/Universal/Suspension/[Vortex] Sport Suspension.tscn") #2
var avalon_track_suspension = preload("res://Assets/Car/Part Lists/Universal/Suspension/[Avalon] Track Suspension.tscn") #3
var suspension = [empty, soft_road_suspension, vortex_sport_suspension, avalon_track_suspension]

#Tires
var EcoMax185R16 = preload("res://Assets/Car/Part Lists/Universal/Tires/185R16 EcoMax.tscn") #1
var Torakushon220R16_semislicks = preload("res://Assets/Car/Part Lists/Universal/Tires/220R16 [Torakushon] Semislick Tires.tscn") #2
var Torakushon260R16_semislicks = preload("res://Assets/Car/Part Lists/Universal/Tires/260R16 [Torakushon] Semislick Tires.tscn") #3
var tires = [empty, EcoMax185R16, Torakushon220R16_semislicks, Torakushon260R16_semislicks]

#Wheels
var cheap_alloy_wheels_180_200_R16 = preload("res://Assets/Car/Part Lists/Universal/Wheels/Cheap Alloy Wheels, 200R16.tscn") #1
var fritz_lightweight_forged_200_220_R16 = preload("res://Assets/Car/Part Lists/Universal/Wheels/[Fritz] Lightweight Forged Wheels, 220R16.tscn") #2
var satetsu_lightweight_forged_260_R16 = preload("res://Assets/Car/Part Lists/Universal/Wheels/[Satetsu] Lightweight Forged Wheels, 260R16.tscn") #3
var wheels = [empty, cheap_alloy_wheels_180_200_R16, fritz_lightweight_forged_200_220_R16, satetsu_lightweight_forged_260_R16]

#Gearbox
var FWD_5speed_manual = preload("res://Assets/Car/Part Lists/Universal/Gearbox/FWD 5 speed manual.tscn") #1
var RWD_6speed_manual = preload("res://Assets/Car/Part Lists/Universal/Gearbox/RWD 6 speed manual.tscn") #2
var AWD_5speed_manual = preload("res://Assets/Car/Part Lists/Universal/Gearbox/AWD 5 speed manual.tscn") #3
var AWD_4speed_manual = preload("res://Assets/Car/Part Lists/Universal/Gearbox/AWD 4 speed manual.tscn") #4
var gearbox = [empty, FWD_5speed_manual, RWD_6speed_manual, AWD_5speed_manual, AWD_4speed_manual]

#Radiator
var small_radiator = preload("res://Assets/Car/Part Lists/Universal/Radiator/Small radiator.tscn")#1
var redline_radiator = preload("res://Assets/Car/Part Lists/Universal/Radiator/[Redline] performance radiator.tscn")#2
var radiator = [empty, small_radiator, redline_radiator]
