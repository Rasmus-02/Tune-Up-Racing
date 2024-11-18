extends Panel
@onready var part_list = $"../../../Parts"
@export var part_stats : Control
@export var function : String
@export var buy_sell_sound : AudioStreamPlayer
@onready var yes_button = $HBoxContainer/Yes
var status = "closed"

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		close()
	#elif Input.is_action_just_pressed("ui_accept"):
	#	_on_yes_pressed()	

func open():
	status = "open"
	self.show()
	yes_button.grab_focus()

func close():
	status = "closed"
	self.hide()
	release_focus()
	part_stats.grab_focus()


func buy_part():
	var part = part_stats.selected_item
	if part.price <= Save_Load.money:
		buy_sell_sound.play()
		Save_Load.money -= int(part.price)
		Save_Load.inv_add(part)
		part_stats.close()

func sell_part():
	var part = part_stats.selected_item
	var price = int(part.price * 0.8 * (float(part.durability) / 100.0))
	buy_sell_sound.play()
	Save_Load.money += int(price)
	Save_Load.remove_inv(part_stats.selected_item)
	part_list.populate_list()
	part_stats.close()

func _on_yes_pressed():
	#Exists in inventory and shop therefore this is needed to decide action
	match function:
		"Buy":
			buy_part()
		"Sell":
			sell_part()
	close()

func _on_no_pressed():
	close()
