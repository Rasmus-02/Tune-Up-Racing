extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")

#Car ID
var id = 5
var stock_engine = 6

#Chassi
var xr2_chassi = preload("res://Assets/Car/Part Lists/Car Specific/Hikari XR2/Chassi/Hikari XR2 Chassi.tscn") #1
var chassi = [xr2_chassi]

#Driveshaft
var stock_rwd_driveshaft = preload("res://Assets/Car/Part Lists/Car Specific/Hikari XR2/Driveshaft/Hikari XR2 Stock Driveshaft.tscn") #1
var driveshaft = [empty, stock_rwd_driveshaft]

#Fenders
var stock_fender = preload("res://Assets/Car/Part Lists/Car Specific/Hikari XR2/Fenders/Hikari XR2 Stock Fenders.tscn") #1
var fenders = [empty, stock_fender]

#F_bumper
var stock_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Hikari XR2/F_bumper/Hikari XR2 Stock Front Bumper.tscn") #1
var f_bumper = [empty, stock_front_bumper]

#Headlights
var stock_headlights = preload("res://Assets/Car/Part Lists/Car Specific/Hikari XR2/Headlights/Hikari XR2 Stock Headlights.tscn") #1
var headlights = [empty, stock_headlights]

#Hood
var stock_hood = preload("res://Assets/Car/Part Lists/Car Specific/Hikari XR2/Hood/Hikari XR2 Stock Hood.tscn") #1
var hood = [empty, stock_hood]

#Mirrors
var stock_mirrors = preload("res://Assets/Car/Part Lists/Car Specific/Hikari XR2/Mirrors/Hikari XR2 Stock Mirrors.tscn") #1
var mirrors = [empty, stock_mirrors]

#R_bumper
var stock_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Hikari XR2/R_bumper/Hikari XR2 Stock Rear Bumper.tscn") #1
var r_bumper = [empty, stock_rear_bumper]

#Subframe
var stock_subframe = preload("res://Assets/Car/Part Lists/Car Specific/Hikari XR2/Subframe/Hikari XR2 Stock Subframe.tscn") #1
var subframe = [empty, stock_subframe]

#Taillights
var stock_taillights = preload("res://Assets/Car/Part Lists/Car Specific/Hikari XR2/Taillights/Hikari XR2 Stock Taillights.tscn") #1
var taillights = [empty, stock_taillights]

#Spoiler
var spoiler = [empty]

#Exhaust
var stock_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Hikari XR2/Exhaust/Hikari XR2 Stock Exhaust.tscn") #1
var exhaust = [empty, stock_exhaust]
