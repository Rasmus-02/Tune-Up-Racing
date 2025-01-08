extends Node

var selected_tab = 0
var specific_parts = null
var universal_parts = null
var car = null
var engine = null
@onready var list = $"../ItemList"
var temp_array = null
var temp_stat_array = []
var temp_part = null
var equipped_part = null #The part that isn't in the inventory
var temp_part_select_part = null
var updated = false
var selected_part = []
var parts = null
var engine_list = {}
var car_list = {}
var block_list = {}
var engine_list_inventory = [] #engine list with just avalible engines
var selected_key = 0
var car_name : String
var active = false
@onready var button_sound = $"../Button_Click"
@onready var stats = $"../../Props/Editor UI Stats/Editor Ui Stats"
var main = null

func _ready():
	main = get_tree().get_root().get_node("Main")

var initiated = false
func initiate():
	main.pause_blocked = true
	list.clear()
	engine_list.clear()
	engine_list_inventory.clear()
	temp_stat_array.clear()
	selected_tab = 0
	specific_parts = null
	SelectedScene.scene = SelectedScene.garage[1]
	car = get_parent().get_parent().get_node("Car_Spawner_Global").lift_car
	engine = car.get_child(3)
	Save_Load.set_engine(engine)
	Save_Load.set_car(car)
	$"../Main_Group/Engine_button".grab_focus()
	animation_controller("main")
	return_button.show()
	populate_list()
	initialise_gearbox_sliders()
	if car != null:
		car_name = car.get_node("Car_spawner").get_child(0).name + " " #used for removing the name of the car from the parts in the editor
	initiated = true


func populate_list():
	stats.change_part(equipped_part, str(selected_tab))
	temp_stat_array.clear()
	$"../Tune_Gearbox".hide() #Hide gearbox_tab
	#for engines
	if selected_tab == 0:
		list.clear()
		engine_list = Save_Load.load_file("engines")
		list.clear()
		var temp_delte_list = [] #list of engines to delete
		temp_delte_list.clear()
		if engine_list == null:
			print("null temp dict")
		else:
			print(engine_list.keys())
			for i in engine_list.keys():
				temp_part = engine_list.get(i)
				print ("¤ " + temp_part.name)
				if temp_part.in_car == null or temp_part.in_car == car.selected_car_key or temp_part.name == "No Engine": #If engine is unequipped or in current car Show it
					list.add_item(temp_part.name)
					print ("+ " + temp_part.name)
					if temp_part.in_car == car.selected_car_key:
						list.set_background_color(list.get_item_count()-1) #Change Background Color of selected part
					list.set_item_custom_fg_color(list.get_item_count()-1,FontColorSettings.get_color(temp_part.rarity)) #set color based on rarity
					size_check(list.get_item_count()-1)
				else:
					temp_delte_list.append(temp_part.key) #engines that are equipped won't show upp, so they get removed from back end too
			list.add_item("[Create Engine]")
			#Remove engines that aren't avalible to equip from list
			engine_list_inventory = engine_list.duplicate() #duplicate to remove dependencies
			
			for keys in temp_delte_list.size():
				engine_list_inventory.erase(temp_delte_list[keys])


	#if "Create Engine" tab selected
	if selected_tab == -1:
		list.clear()
		block_list = AssetList.get_parts("Block", 5, null, "", "Save")
		for block in block_list:
			list.add_item(block.name)
			list.set_item_custom_fg_color(list.get_item_count()-1,FontColorSettings.get_color(block.rarity)) #set color based on rarity
	
	#for other parts than engine
	var list_index = 0
	if selected_tab > 0 and selected_tab != 18:
		list.clear()
		for i in temp_array.size()+1:
			temp_part = temp_array[list_index].instantiate()
			var checked_part = Save_Load.inv_check(temp_part)
			if temp_part.Part_Number == 0: #EMPTY PART
				list.add_item(temp_part.name)
				temp_stat_array.append([0,0]) #adds empty value
			elif i == 1 and temp_stat_array.size() != 2: #If empty part and equipped part has been added
				if equipped_part.name != "[empty]":
					var part_name = equipped_part.name
					part_name = part_name.replace(car_name, "") #reformat name
					list.add_item(part_name)
					list.set_background_color(list.get_item_count()-1)
					temp_stat_array.append([equipped_part.durability, equipped_part.color])
					list.set_item_custom_fg_color(list.get_item_count()-1,FontColorSettings.get_color(equipped_part.rarity)) #set color based on rarity
				list_index -= 1
			elif checked_part.size() > 0: #checks if the part exists in the players inventory
				for n in checked_part.size():
					temp_stat_array.append(checked_part[n])
					#Part name is used for seperating the car name from the part to make the engine ui cleaner (doesn't need the car name here)
					var part_name = temp_part.name
					part_name = part_name.replace(car_name, "")
					list.add_item(part_name)
					
					#Make it so it is impossible to equip wrong gearbox
					if selected_tab == 15: #GEARBOX
						if temp_part.drivetrain != car.drive_train_type:
							list.set_item_disabled(list.item_count-1+n, true)
					if selected_tab == 14: #DRIVESHAFT
						if temp_part.drivetrain != car.gearbox.drivetrain and car.drive_train_type != 9999 and car.gearbox.drivetrain != 9999: #Can't have different drivetrain than the gearbox
							list.set_item_disabled(list.item_count-1+n, true)
					
					#Make it so it is impossible to equip wrong tires on wrong wheels
					if selected_tab == 10: #Wheel
						if temp_part.diameter != car.tires.diameter and car.tires.diameter != 0:
							list.set_item_disabled(list.item_count-1+n, true)
						if temp_part.max_tire_width < car.tires.width:
							list.set_item_disabled(list.item_count-1+n, true)
					if selected_tab == 11: #Tires:
						if temp_part.diameter != car.wheels.diameter and temp_part.diameter != 0: #If not same diameter as wheels disable, but if empty, don't disable
							list.set_item_disabled(list.item_count-1+n, true)
						if temp_part.width > car.wheels.max_tire_width:
							list.set_item_disabled(list.item_count-1+n, true)
					
					list.set_item_custom_fg_color(list.get_item_count()-1,FontColorSettings.get_color(temp_part.rarity)) #set color based on rarity
			list_index += 1
	
	#Disable empty part (Needs to be outside for loop, because if player owns 1 part that is equipped for loop won't run)
	if selected_tab == 15: #GEARBOX
		if car.selected_engine != "0": #Can't unequip gearbox if there is an engine in the car
			list.set_item_disabled(0, true)
	if selected_tab == 14: #DRIVESHAFT
		if car.selected_gearbox != 0: #Can't unequip drivetrain if there is a gearbox installed
			list.set_item_disabled(0, true)
	if selected_tab == 10: #Wheel
		if car.tires.diameter > 0: #Can't unequip wheel if tire is installed
			list.set_item_disabled(0, true)

func size_check(index):
	var left = temp_part.size[0]
	var right = temp_part.size[1]
	var front = temp_part.size[2]
	var engine_bay = car.engine_bay_size
	var engine_offset = null
	engine_offset = car.engine_position_offset
	var engine_bay_width_left = (engine_bay[1]*0.5) + engine_offset.y
	var engine_bay_width_right = (engine_bay[1]*0.5) - engine_offset.y
	var engine_bay_lenght_front = (engine_bay[0]) - engine_offset.x
	var engine_bay_lenght_rear = engine_offset.x

	if car.drive_train_type == 1: #Transverse (fwd) rotated 90degrees so side beckome back and forward
		if left > engine_bay_lenght_rear or right > engine_bay_lenght_front or front > engine_bay_width_left:
			list.set_item_disabled(index, true)
	elif left > engine_bay_width_left or right > engine_bay_width_right or front > engine_bay_lenght_front:
		list.set_item_disabled(index, true)

var loaded = false
func _physics_process(_delta):
	if active == true:
		if initiated == false:
			initiate()
		#update lists when ready
		if car.get_child(0).get_child(0) != null and specific_parts == null:
			specific_parts = car.get_child(0).get_child(0).get_child(0).get_child(0) #from part list specific to the car
			universal_parts = car.get_child(0).get_child(0).get_child(0).get_child(1)
		if selected_tab == 18:
			gearbox_sliders()
		if updated == true:
			updated = false
		if Input.is_action_just_pressed("ui_cancel"):
			_on_return_button_pressed()


func _on_item_selected(index): #when a part in the item list is clicked (node signal)
	print(index)
	button_sound.play()
	#if statement for finding the correct engine
	if selected_tab == 0 and index < engine_list_inventory.size(): #update engine if (CREATE ENGINE) Not pressed
		Save_Load.save()
		#Add deselected engine back to inventory
		engine.in_car = null
		Save_Load.edit_engine(engine)
		#update list of engines
		selected_key = engine_list_inventory.keys()[index] #the key for the engine that got selected
		print(engine_list_inventory.keys(),"  ",selected_key,"    ", engine_list_inventory.get(str(selected_key)))
		temp_part_select_part = engine_list_inventory.get(str(selected_key))
	
	elif selected_tab == 0: #If "Create Engine" clicked
		selected_tab = -1
		populate_list()
	
	elif selected_tab == -1: #If in "Block Selector" in "Create Engine", add engine and go back to engine selector
		add_engine(block_list[index])
		selected_tab = 0
		populate_list()
	
	else: #If not engine
		for i in temp_array.size():
			temp_part_select_part = temp_array[i].instantiate()
			if temp_part_select_part.get_name() == car_name + list.get_item_text(index) or temp_part_select_part.get_name() == list.get_item_text(index): #if correct part by name
				break
			elif index == 0: #If empty part
				break
			temp_part_select_part.queue_free()
			i += 1
		#Update Stat Tab
		temp_part_select_part.durability = temp_stat_array[index][0]
		temp_part_select_part.color = temp_stat_array[index][1]
	#sends update to engine that parts have changed
	match selected_tab:
		0:
			car.selected_engine = selected_key
			if car.selected_engine != null:
				#Forces the key to be correct (or at least it should be?)
				Save_Load.temp_key = selected_key
				update_car()
				update_engine()
				Save_Load.temp_key = selected_key
				engine.selected_engine_key = selected_key
				engine.in_car = car.selected_car_key
				Save_Load.edit_engine(engine)
			else:
				engine.queue_free()
			#Refresh list
			list.clear()
			populate_list()
			
		1:
			equipped_part = car.f_bumper
			if index != 1 or (equipped_part.name == "[empty]" and index > 0):
				if car.f_bumper.name != "[empty]":
					Save_Load.inv_add(car.f_bumper)
				if temp_part_select_part.name != "[empty]":
					Save_Load.remove_inv(temp_part_select_part)
			
			car.selected_f_bumper = temp_part_select_part.Part_Number
			car.f_bumper_durability = temp_stat_array[index][0]
			car.f_bumper_color = temp_stat_array[index][1]
			update_car()
			_on_front__bumper_button_pressed()
		2:
			equipped_part = car.r_bumper
			if index != 1 or (equipped_part.name == "[empty]" and index > 0):
				if car.r_bumper.name != "[empty]":
					Save_Load.inv_add(car.r_bumper)
				if temp_part_select_part.name != "[empty]":
					Save_Load.remove_inv(temp_part_select_part)
			
			car.selected_r_bumper = temp_part_select_part.Part_Number
			car.r_bumper_durability = temp_stat_array[index][0]
			car.r_bumper_color = temp_stat_array[index][1]
			update_car()
			_on_rear_bumper_button_pressed()
		3:
			equipped_part = car.fenders
			if index != 1 or (equipped_part.name == "[empty]" and index > 0):
				if car.fenders.name != "[empty]":
					Save_Load.inv_add(car.fenders)
				if temp_part_select_part.name != "[empty]":
					Save_Load.remove_inv(temp_part_select_part)
			
			car.selected_fenders = temp_part_select_part.Part_Number
			car.fenders_durability = temp_stat_array[index][0]
			car.fenders_color = temp_stat_array[index][1]
			update_car()
			_on_fenders_button_pressed()
		4:
			equipped_part = car.hood
			if index != 1 or (equipped_part.name == "[empty]" and index > 0):
				if car.hood.name != "[empty]":
					Save_Load.inv_add(car.hood)
				if temp_part_select_part.name != "[empty]":
					Save_Load.remove_inv(temp_part_select_part)
			
			car.selected_hood = temp_part_select_part.Part_Number
			car.hood_durability = temp_stat_array[index][0]
			car.hood_color = temp_stat_array[index][1]
			update_car()
			_on_hood_button_pressed()
		5:
			equipped_part = car.mirrors
			if index != 1 or (equipped_part.name == "[empty]" and index > 0):
				if car.mirrors.name != "[empty]":
					Save_Load.inv_add(car.mirrors)
				if temp_part_select_part.name != "[empty]":
					Save_Load.remove_inv(temp_part_select_part)
			
			car.selected_mirrors = temp_part_select_part.Part_Number
			car.mirrors_durability = temp_stat_array[index][0]
			car.mirrors_color = temp_stat_array[index][1]
			update_car()
			_on_mirrors_button_pressed()
		6:
			equipped_part = car.headlights
			if index != 1 or (equipped_part.name == "[empty]" and index > 0):
				if car.headlights.name != "[empty]":
					Save_Load.inv_add(car.headlights)
				if temp_part_select_part.name != "[empty]":
					Save_Load.remove_inv(temp_part_select_part)
			
			car.selected_headlights = temp_part_select_part.Part_Number
			car.headlights_durability = temp_stat_array[index][0]
			car.headlights_color = temp_stat_array[index][1]
			update_car()
			_on_headlights_button_pressed()
		7:
			equipped_part = car.taillights
			if index != 1 or (equipped_part.name == "[empty]" and index > 0):
				if car.taillights.name != "[empty]":
					Save_Load.inv_add(car.taillights)
				if temp_part_select_part.name != "[empty]":
					Save_Load.remove_inv(temp_part_select_part)
			
			car.selected_taillights = temp_part_select_part.Part_Number
			car.taillights_durability = temp_stat_array[index][0]
			car.taillights_color = temp_stat_array[index][1]
			update_car()
			_on_taillights_button_pressed()
		8:
			equipped_part = car.spoiler
			if index != 1 or (equipped_part.name == "[empty]" and index > 0):
				if car.spoiler.name != "[empty]":
					Save_Load.inv_add(car.spoiler)
				if temp_part_select_part.name != "[empty]":
					Save_Load.remove_inv(temp_part_select_part)
			
			car.selected_spoiler = temp_part_select_part.Part_Number
			car.spoiler_durability = temp_stat_array[index][0]
			car.spoiler_color = temp_stat_array[index][1]
			update_car()
			_on_spoiler_button_pressed()
		9:
			equipped_part = car.suspension
			if index != 1 or (equipped_part.name == "[empty]" and index > 0):
				if car.suspension.name != "[empty]":
					Save_Load.inv_add(car.suspension)
				if temp_part_select_part.name != "[empty]":
					Save_Load.remove_inv(temp_part_select_part)
			
			car.selected_suspension = temp_part_select_part.Part_Number
			car.suspension_durability = temp_stat_array[index][0]
			update_car()
			_on_suspension_button_pressed()
		10:
			equipped_part = car.wheels
			if index != 1 or (equipped_part.name == "[empty]" and index > 0):
				if car.wheels.name != "[empty]":
					Save_Load.inv_add(car.wheels)
				if temp_part_select_part.name != "[empty]":
					Save_Load.remove_inv(temp_part_select_part)
			
			car.selected_wheels = temp_part_select_part.Part_Number
			car.wheels_durability = temp_stat_array[index][0]
			update_car()
			_on_wheels_button_pressed()
		11:
			equipped_part = car.tires
			if index != 1 or (equipped_part.name == "[empty]" and index > 0):
				if car.tires.name != "[empty]":
					Save_Load.inv_add(car.tires)
				if temp_part_select_part.name != "[empty]":
					Save_Load.remove_inv(temp_part_select_part)
			
			car.selected_tires = temp_part_select_part.Part_Number
			car.tires_durability = temp_stat_array[index][0]
			update_car()
			_on_tires_button_pressed()
		12:
			equipped_part = car.brakes
			if index != 1 or (equipped_part.name == "[empty]" and index > 0):
				if car.brakes.name != "[empty]":
					Save_Load.inv_add(car.brakes)
				if temp_part_select_part.name != "[empty]":
					Save_Load.remove_inv(temp_part_select_part)
			
			car.selected_brakes = temp_part_select_part.Part_Number
			car.brakes_durability = temp_stat_array[index][0]
			update_car()
			_on_brakes_button_pressed()
		13:
			equipped_part = car.subframe
			if index != 1 or (equipped_part.name == "[empty]" and index > 0):
				if car.subframe.name != "[empty]":
					Save_Load.inv_add(car.subframe)
				if temp_part_select_part.name != "[empty]":
					Save_Load.remove_inv(temp_part_select_part)
			
			car.selected_subframe = temp_part_select_part.Part_Number
			car.subframe_durability = temp_stat_array[index][0]
			update_car()
			_on_subframe_button_pressed()
		14:
			equipped_part = car.driveshaft
			if index != 1 or (equipped_part.name == "[empty]" and index > 0):
				if car.driveshaft.name != "[empty]":
					Save_Load.inv_add(car.driveshaft)
				if temp_part_select_part.name != "[empty]":
					Save_Load.remove_inv(temp_part_select_part)
			
			car.selected_driveshaft = temp_part_select_part.Part_Number
			car.driveshaft_durability = temp_stat_array[index][0]
			update_car()
			#populate list used to be here, if any problems with driveshaft updating
			_on_driveshaft_button_pressed()
		15:
			equipped_part = car.gearbox
			if index != 1 or (equipped_part.name == "[empty]" and index > 0):
				if car.gearbox.name != "[empty]":
					Save_Load.inv_add(car.gearbox)
				if temp_part_select_part.name != "[empty]":
					Save_Load.remove_inv(temp_part_select_part)
			
			car.selected_gearbox = temp_part_select_part.Part_Number
			car.gearbox_durability = temp_stat_array[index][0]
			update_car()
			_on_gearbox_button_pressed()
		16:
			equipped_part = car.radiator
			if index != 1 or (equipped_part.name == "[empty]" and index > 0):
				if car.radiator.name != "[empty]":
					Save_Load.inv_add(car.radiator)
				if temp_part_select_part.name != "[empty]":
					Save_Load.remove_inv(temp_part_select_part)
			
			car.selected_radiator = temp_part_select_part.Part_Number
			car.radiator_durability = temp_stat_array[index][0]
			update_car()
			_on_radiator_button_pressed()
		17:
			equipped_part = car.exhaust
			if index != 1 or (equipped_part.name == "[empty]" and index > 0):
				if car.exhaust.name != "[empty]":
					Save_Load.inv_add(car.exhaust)
				if temp_part_select_part.name != "[empty]":
					Save_Load.remove_inv(temp_part_select_part)
			
			car.selected_exhaust = temp_part_select_part.Part_Number
			car.exhaust_durability = temp_stat_array[index][0]
			update_car()
			_on_exhaust_button_pressed()

func update_car():
	car.update_car_parts()
	_on_save_pressed()
	if selected_tab > 0 and selected_tab != 18:
		$"../Description".text = temp_part_select_part.description

func update_engine():
	engine.update_engine_parts()
	#_on_save_pressed()
	engine.load_engine(selected_key)

func open_engine_editor():
	if car.selected_engine != "0":
		update_car()
		$"../Tune_Gearbox".hide()
		animation_controller("engine")
		active = false
		$"../Engine Edit Controller".instantiated = false
		$"../Engine Edit Controller".active = true


@onready var body_group = $"../Body_Group"
@onready var main_group = $"../Main_Group"
@onready var suspension_group = $"../Suspension_Group"
@onready var frame_group = $"../Frame_Group"
@onready var engine_group = $"../Engine_Group"
@onready var return_button = $"../Return Button"
@onready var button_animation = $"../../Props/Editor UI Buttons"
@onready var stats_animation = $"../../Props/Editor UI Stats"
@onready var scroll_menu_animation = $"../../Props/Editor UI Scroll Menu"

func _on_engine_button_pressed():
	if selected_tab == 0:
		open_engine_editor()
	else:
		selected_tab = 0
		button_sound.play()
		populate_list()

#Body Tab ======================================================================
func _on_body_button_pressed():
	animation_controller("body")
	_on_front__bumper_button_pressed()
	$"../Body_Group/Front _bumper_button".grab_focus()

func _on_front__bumper_button_pressed():
	button_sound.play()
	temp_array = specific_parts.f_bumper
	selected_tab = 1
	equipped_part = car.f_bumper #updates the equipped part
	populate_list()
func _on_rear_bumper_button_pressed():
	button_sound.play()
	temp_array = specific_parts.r_bumper
	selected_tab = 2
	equipped_part = car.r_bumper #updates the equipped part
	populate_list()
func _on_fenders_button_pressed():
	button_sound.play()
	temp_array = specific_parts.fenders
	selected_tab = 3
	equipped_part = car.fenders #updates the equipped part
	populate_list()
func _on_hood_button_pressed():
	button_sound.play()
	temp_array = specific_parts.hood
	selected_tab = 4
	equipped_part = car.hood #updates the equipped part
	populate_list()
func _on_mirrors_button_pressed():
	button_sound.play()
	temp_array = specific_parts.mirrors
	selected_tab = 5
	equipped_part = car.mirrors #updates the equipped part
	populate_list()
func _on_headlights_button_pressed():
	button_sound.play()
	temp_array = specific_parts.headlights
	selected_tab = 6
	equipped_part = car.headlights #updates the equipped part
	populate_list()
func _on_taillights_button_pressed():
	button_sound.play()
	temp_array = specific_parts.taillights
	selected_tab = 7
	equipped_part = car.taillights #updates the equipped part
	populate_list()
func _on_spoiler_button_pressed():
	button_sound.play()
	temp_array = specific_parts.spoiler
	selected_tab = 8
	equipped_part = car.spoiler #updates the equipped part
	populate_list()
#===============================================================================

#Suspension tab ================================================================
func _on_suspension_wheel__button_pressed():
	animation_controller("suspension")
	populate_list()
	_on_suspension_button_pressed()
	$"../Suspension_Group/Suspension_button".grab_focus()
	
func _on_suspension_button_pressed():
	button_sound.play()
	temp_array = universal_parts.suspension
	selected_tab = 9
	equipped_part = car.suspension #updates the equipped part
	populate_list()
func _on_wheels_button_pressed():
	button_sound.play()
	temp_array = universal_parts.wheels
	selected_tab = 10
	equipped_part = car.wheels #updates the equipped part
	populate_list()
func _on_tires_button_pressed():
	button_sound.play()
	temp_array = universal_parts.tires
	selected_tab = 11
	equipped_part = car.tires #updates the equipped part
	populate_list()
func _on_brakes_button_pressed():
	button_sound.play()
	temp_array = universal_parts.brakes
	selected_tab = 12
	equipped_part = car.brakes #updates the equipped part
	populate_list()
#===============================================================================

#Frame tab =====================================================================
func _on_frame_button_pressed():
	animation_controller("frame")
	populate_list()
	_on_subframe_button_pressed()
	$"../Frame_Group/Subframe_button".grab_focus()

func _on_subframe_button_pressed():
	button_sound.play()
	temp_array = specific_parts.subframe
	selected_tab = 13
	equipped_part = car.subframe #updates the equipped part
	populate_list()
func _on_driveshaft_button_pressed():
	button_sound.play()
	temp_array = specific_parts.driveshaft
	selected_tab = 14
	equipped_part = car.driveshaft #updates the equipped part
	populate_list()
func _on_gearbox_button_pressed():
	button_sound.play()
	temp_array = universal_parts.gearbox
	selected_tab = 15
	equipped_part = car.gearbox #updates the equipped part
	populate_list()

func _on_radiator_button_pressed():
	button_sound.play()
	temp_array = universal_parts.radiator
	selected_tab = 16
	equipped_part = car.radiator #updates the equipped part
	populate_list()

func _on_exhaust_button_pressed():
	button_sound.play()
	temp_array = specific_parts.exhaust
	selected_tab = 17
	equipped_part = car.exhaust #updates the equipped part
	populate_list()
#===============================================================================

#Tune Button ===================================================================
func _on_tune_button_pressed():
	save_gearbox_stats()
	button_sound.play()
	list.clear()
	selected_tab = 18
	
	for n in car.max_gear:
		$"../Tune_Gearbox/Sliders".get_child(n).value = car.gear_ratio[n]
		$"../Tune_Gearbox/Stats".get_child(n).set_text(str($"../Tune_Gearbox/Sliders".get_child(n).value))
		$"../Tune_Gearbox".show()
		$"../Tune_Gearbox/Sliders".get_child(n).show()
		$"../Tune_Gearbox/Stats".get_child(n).show()
#===============================================================================
func _on_return_button_pressed():
	var engine_editor = $"../Engine Edit Controller"
	$"../Tune_Gearbox".hide()
	button_sound.play()
	if current_animation == "main" and active == true: #Close editor
		save_gearbox_stats() #Save tuned gearbox ratios
		update_car()
		active = false
		main_group.hide()
		return_button.hide()
		button_animation.queue("Close Main")
		scroll_menu_animation.queue("Close Menu")
		stats_animation.queue("Turn Off")
		SelectedScene.scene = SelectedScene.garage[0]
		current_animation = null
		list.clear()
		main.pause_blocked = false
	elif engine_editor.selected_tab != 7: #Back To Main tab from sub-tabs
		animation_controller("main")
		$"../Main_Group/Engine_button".grab_focus()
		selected_tab = 0
		#Exit engine controller
		if engine_editor.active == true and engine.selected_block == 0:
			var engine_to_remove = engine.selected_engine_key #Memorize key
			_on_item_selected(0) #Change engine to "Empty Engine"
			Save_Load.remove_engine(engine_to_remove) #Remove empty engine from inventory
			
		populate_list()

func initialise_gearbox_sliders():
	for n in car.max_gear:
		$"../Tune_Gearbox/Sliders".get_child(n).value = car.gear_ratio[n]

func gearbox_sliders():
	for n in car.max_gear:
		$"../Tune_Gearbox/Stats".get_child(n).set_text(str($"../Tune_Gearbox/Sliders".get_child(n).value))

func save_gearbox_stats():
	#update the gear ratios to the ones in the editor
	car.gear_ratio.clear()
	for n in car.max_gear:
		car.gear_ratio.append($"../Tune_Gearbox/Sliders".get_child(n).value)
	#reset the shown sliders
	for n in $"../Tune_Gearbox/Sliders".get_child_count():
		$"../Tune_Gearbox/Sliders".get_child(n).hide()
		$"../Tune_Gearbox/Stats".get_child(n).hide()
	


var current_animation = null
func animation_controller(new_animation):
	#Close a tab before opening a new tab
	if current_animation == null:
		pass
	else:
		match current_animation:
			"main":
				if new_animation != "main":
					button_animation.queue("Close Main")
					main_group.hide()
			"body":
				button_animation.queue("Close Body")
				body_group.hide()
			"suspension":
				button_animation.queue("Close Suspension")
				suspension_group.hide()
			"frame":
				button_animation.queue("Close Frame")
				frame_group.hide()
			"engine":
				button_animation.queue("Close Engine")
				engine_group.hide()
	#Play open animation
	match new_animation:
		"main":
			if current_animation != "main":
				button_animation.queue("Main")
				main_group.show()
				if current_animation == null:
					stats_animation.queue("Turn On")
					scroll_menu_animation.queue("Open Menu")
		"body":
			button_animation.queue("Body")
			body_group.show()
		"suspension":
			button_animation.queue("Suspension")
			suspension_group.show()
		"frame":
			button_animation.queue("Frame")
			frame_group.show()
		"engine":
			button_animation.queue("Engine")
			engine_group.show()
	#Update Current animation
	current_animation = new_animation


var key #to be replaced
var selected_car_part = null
func _on_save_pressed():
	key = Save_Load.load_file("selected_car_key")
	car.selected_car_key = key
	Save_Load.temp_key = Save_Load.select_car(key).engine #engine key
	Save_Load.temp_key_car = key #car key
	Save_Load.edit_car(car)
	Save_Load.save()
	car_list = Save_Load.load_file("cars")

func add_engine(block):
	button_sound.play()
	var new_selected_key = Save_Load.largest_key("engine", null) + 1
	engine.selected_block = block.Part_Number
	engine.selected_internals = 0
	engine.selected_top = 0
	engine.selected_exhaust_manifold = 0
	engine.selected_intake_manifold = 0
	engine.selected_air_filter = 0
	engine.selected_engine = block.Engine_ID
	engine.selected_engine_key = new_selected_key
	engine.block_durability = block.durability
	engine.internals_durability = 100
	engine.top_durability = 100
	engine.exhaust_manifold_durability = 100
	engine.intake_manifold_durability = 100
	engine.air_filter_durability = 100
	engine.in_car = null
	Save_Load.temp_key = new_selected_key
	engine.refresh_spawner()
	engine.update_engine_parts()
	Save_Load.add_engine() #Add the engine with the selected parts to inventory
	Save_Load.remove_inv(block) #Remove the engine part from the inventory to prevent duplication








#FOR TESTING#
func _on_add_pressed():
	car_list = Save_Load.load_file("cars")
	key = Save_Load.largest_key("car", null) + 1
	Save_Load.set_car(car)
	car.selected_car = 0
	car.selected_car_key = key
	car.selected_engine = 0
	car.selected_chassi = 0
	car.selected_f_bumper = 0
	car.selected_r_bumper = 0
	car.selected_fenders = 0
	car.selected_hood = 0
	car.selected_mirrors = 0
	car.selected_headlights = 0
	car.selected_taillights = 0
	car.selected_spoiler = 0
	car.selected_suspension = 0
	car.selected_wheels = 0
	car.selected_tires = 0
	car.selected_brakes = 0
	car.selected_subframe = 0
	car.selected_driveshaft = 0
	car.selected_gearbox = 0
	car.selected_exhaust = 0
	car.selected_color = Color(0.5,0.5,0.5,1)
	car.update_car_parts()
	Save_Load.add_car()


