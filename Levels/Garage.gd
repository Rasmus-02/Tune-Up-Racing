extends Node2D

var scene = "car"

#Scene garage = ["garage", "CE", "EE", "CE_body", "CE_suspension", "CE_frame"]

func _ready():
	SelectedScene.scene = SelectedScene.garage[0]

func _process(_delta):
	pass
	#if Input.is_action_just_pressed("Handbrake"):
	#	Save_Load.inv_add({"Type" : 1, "Part_number" : 5, "Part_Type" : 4, "ID" : 2, "Durability" : 100})
	#	Save_Load.inv_add({"Type" : 1, "Part_number" : 11, "Part_Type" : 3, "ID" : 2, "Durability" : 100})
	#	Save_Load.inv_add({"Type" : 1, "Part_number" : 12, "Part_Type" : 3, "ID" : 2, "Durability" : 100})
	#	Save_Load.inv_add({"Type" : 0, "Part_number" : 3, "Part_Type" : 3, "ID" : 0, "Durability" : 100})
	#	Save_Load.inv_add({"Type" : 0, "Part_number" : 2, "Part_Type" : 7, "ID" : 0, "Durability" : 100})
	#	Save_Load.inv_add({"Type" : 0, "Part_number" : 1, "Part_Type" : 17, "ID" : 1, "Durability" : 100})
	#	Save_Load.inv_add({"Type" : 0, "Part_number" : 1, "Part_Type" : 17, "ID" : 2, "Durability" : 100})
	#	Save_Load.inv_add({"Type" : 0, "Part_number" : 3, "Part_Type" : 3, "ID" : 1, "Durability" : 100})
	#	Save_Load.inv_add({"Type" : 1, "Part_number" : 3, "Part_Type" : 4, "ID" : 3, "Durability" : 100})
	#	Save_Load.inv_add({"Type" : 1, "Part_number" : 4, "Part_Type" : 4, "ID" : 3, "Durability" : 100})
	#	Save_Load.inv_add({"Type" : 1, "Part_number" : 2, "Part_Type" : 2, "ID" : 2, "Durability" : 100})
	#	Save_Load.inv_add({"Type" : 1, "Part_number" : 4, "Part_Type" : 4, "ID" : 2, "Durability" : 100})
	#	Save_Load.inv_add({"Type" : 0, "Part_number" : 2, "Part_Type" : 5, "ID" : 0, "Durability" : 100})
	#	Save_Load.inv_add({"Type" : 0, "Part_number" : 2, "Part_Type" : 2, "ID" : 0, "Durability" : 100})
		#Save_Load.inv_add({"Type" : 0, "Part_number" : 2, "Part_Type" : 14, "ID" : 9999, "Durability" : 100})
		#for i in 15:
		#	Save_Load.remove_inv(i)
		#Save_Load.inv_add({"Type" : 1, "Part_number" : 1, "Part_Type" : 0, "ID" : 3, "Durability" : 100})
		#Save_Load.inv_add({"Type" : 1, "Part_number" : 1, "Part_Type" : 1, "ID" : 3, "Durability" : 100})
		#Save_Load.inv_add({"Type" : 1, "Part_number" : 2, "Part_Type" : 1, "ID" : 3, "Durability" : 100})
		#Save_Load.inv_add({"Type" : 1, "Part_number" : 1, "Part_Type" : 2, "ID" : 3, "Durability" : 100})
		#Save_Load.inv_add({"Type" : 1, "Part_number" : 1, "Part_Type" : 3, "ID" : 3, "Durability" : 100})
		#Save_Load.inv_add({"Type" : 1, "Part_number" : 1, "Part_Type" : 4, "ID" : 3, "Durability" : 100})
		#Save_Load.inv_add({"Type" : 3, "Part_number" : 1, "Part_Type" : 5, "ID" : 9999, "Durability" : 100})

func drive():
	get_parent().change_scene("costal_circuit")
	#SelectedScene.next_scene = "res://Levels/Costal_Circuit_Scene.tscn"
	#get_tree().change_scene_to_file("res://Levels/loading.tscn")
