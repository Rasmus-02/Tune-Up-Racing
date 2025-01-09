extends Node2D

var empty = preload("res://Assets/Empty Part/Empty_Part.tscn")

#Chassi
var koi_chassi = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Chassi/Nagata Koi Chassi.tscn") #0
var chassi = [koi_chassi]

#Driveshaft
var stock_fwd_driveshaft = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Driveshaft/Nagata Koi Stock FWD Driveshaft.tscn") #0
var driveshaft = [empty, stock_fwd_driveshaft]

#Fenders
var stock_fender = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Fenders/Nagata Koi Stock Fenders.tscn") #0
var fenders = [empty, stock_fender]

#F_bumper
var stock_front_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/F_bumper/Nagata Koi Stock Front Bumper.tscn") #0
var f_bumper = [empty, stock_front_bumper]

#Headlights
var stock_headlights = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Headlights/Nagata Koi Stock Headlights.tscn")
var headlights = [empty, stock_headlights]

#Hood
var stock_hood = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Hood/Nagata Koi Stock Hood.tscn")
var hood = [empty, stock_hood]

#Mirrors
var stock_mirrors = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Mirrors/Nagat Koi Stock Mirrors.tscn")
var mirrors = [empty, stock_mirrors]

#R_bumper
var stock_rear_bumper = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/R_bumper/Nagata Koi Stock Rear Bumper.tscn")
var r_bumper = [empty, stock_rear_bumper]

#Subframe
var stock_subframe = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Subframe/Nagata Koi Stock Subframe.tscn")
var subframe = [empty, stock_subframe]

#Taillights
var stock_taillights = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Taillights/Nagata Koi Stock Taillights.tscn")
var taillights = [empty, stock_taillights]

#Windows
var roof_spoiler = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Spoiler/Nagata Koi Factory Roof Spoiler.tscn")
var spoiler = [empty, roof_spoiler]

#Exhaust
var stock_exhaust = preload("res://Assets/Car/Part Lists/Car Specific/Nagata Koi/Exhaust/Nagata Koi Stock Exhaust.tscn")
var exhaust = [empty, stock_exhaust]
