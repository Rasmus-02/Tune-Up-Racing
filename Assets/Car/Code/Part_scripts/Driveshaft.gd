extends Node2D

@export_category("ID")
@export_enum("common", "uncommon", "rare", "epic", "legendary") var rarity : String
@export var Car_ID : int
@export var Part_Number : int
var type = 0 #car or engine
var id = [Car_ID,1,Part_Number,rarity] #Engine ID, Part type, Part number, rank
@export_multiline var description = ""

@export_category("Stats")
@export_range(0 , 10000000) var price : int
@export var weight = 0
@export_enum("RWD", "FWD", "AWD") var drivetrain : int #0=RWD, 1=FWD, 2=AWD
@export var max_torque = 0
@export var drivetrain_loss = 0.0 #FWD: 10-15% loss,  RWD: 10-18% loss,  AWD: 17-25% loss

var durability = 100 #100%
var color = 0




# ORPHAN NODE HANDLER, DELETE WHEN SCENE CHANGE
func _init():
	Utils.connect("freeing_orphans", Callable(self, "_free_if_orphaned"))
func _free_if_orphaned():
	if not is_inside_tree(): # Optional check - don't free if in the scene tree
		queue_free()
