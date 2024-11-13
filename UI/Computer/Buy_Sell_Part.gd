extends Panel
@export var part_stats : Control
@export var function : String
var status = "closed"

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		close()

func open():
	status = "open"
	self.show()
	grab_focus()

func close():
	status = "closed"
	self.hide()
	release_focus()
	part_stats.grab_focus()


func buy_part():
	var part = part_stats.selected_item
	if part.price <= Save_Load.money:
		var type = part.type
		var part_number = part.Part_Number
		var part_type = part.id[1]
		var id = null #Gets defined in the if statements bellow because of different names
		if type == 0:
			id = part.Car_ID
		elif type == 1:
			id = part.Engine_ID
		Save_Load.money -= int(part.price)
		Save_Load.save()
		Save_Load.inv_add({"Type" : type, "Part_number" : part_number, "Part_Type" : part_type, "ID" : id, "Durability" : 100})

func sell_part():
	var part = part_stats.selected_item
	var price = int(part.price * 0.8 * (float(part.durability) / 100.0))
	Save_Load.money += int(price)
	Save_Load.save()
	#Save_Load.inv_add({"Type" : type, "Part_number" : part_number, "Part_Type" : part_type, "ID" : id, "Durability" : 100})

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
