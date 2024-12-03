extends Control

@export var xp_label : Label
@export var money_label : Label
@export var label : Label
@export var description : Label

#Refreshes label text
func update_text(xp : int, money : int, label_text : String, description_text : String):
	xp_label.text = "+" + str(xp) + "XP"
	money_label.text = "+" + str(money) + "$"
	label.text = label_text
	description.text = description_text
