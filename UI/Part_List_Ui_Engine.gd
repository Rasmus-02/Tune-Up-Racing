extends Node

var selected_tab = 0
var part_category = null
var specific_parts = null
var universal_parts = null
var equipped_part = null
var engine = null
@onready var list = $"../ItemList"
var temp_array = null
var temp_stat_array = []
var temp_part = null
var temp_part_select_part = null
var updated = false
var selected_part = null
var engine_bay_size = [1, 1]
var drivetype = 0
var engine_position_offset = Vector2(0,0)
var active = false
var instantiated = false
var engine_name : String
@onready var button_sound = $"../Button_Click"

@onready var boost_slider = $"../Tune/SLiders_Container/Boost_Slider"
@onready var rpm_slider = $"../Tune/SLiders_Container/RPM_Slider"
@onready var boost_text = $"../Tune/Stats/Boost_Text"
@onready var rpm_text = $"../Tune/Stats/RPM_Text"
@onready var stats = $"../../Props/Editor UI Stats/Editor Ui Stats"



func instantiate():
	SelectedScene.scene = SelectedScene.garage[1]
	specific_parts = null
	var car = $"../Car Edit Controller".car
	engine = car.engine
	engine_bay_size = car.engine_bay_size
	drivetype = car.drive_train_type
	Save_Load.temp_key = engine.selected_engine_key
	Save_Load.set_engine(engine)
	specific_parts = engine.get_child(0).get_child(0).get_child(0).get_child(0) #from part list specific to the engine
	universal_parts = engine.get_child(0).get_child(0).get_child(0).get_child(1) #from universal part list
	selected_part = specific_parts.block
	
	$"../Engine_Group/Block_button".grab_focus()
	temp_array = specific_parts.block
	equipped_part = engine.block
	part_category = "block"
	selected_tab = 0
	if engine != null:
		engine_name = engine.get_node("Engine_spawner").get_child(0).name + " " #used for removing the name of the engine from the parts in the editor
	populate_list()
	instantiated = true

func populate_list():
	temp_stat_array.clear()
	list.clear()
	var list_index = 0
	for i in temp_array.size()+1:
		temp_part = temp_array[list_index].instantiate()
		var checked_part = Save_Load.inv_check(temp_part)
		if temp_part.Part_Number == 0: #If empty
			list.add_item(temp_part.name)
			temp_stat_array.append([0,0]) #adds empty value
		elif i == 1 and temp_stat_array.size() != 2: #If empty part and equipped part has been added
			if equipped_part.name != "[empty]":
				var part_name = equipped_part.name
				part_name = part_name.replace(engine_name, "") #reformat name
				list.add_item(part_name)
				list.set_background_color(list.get_item_count()-1)
				temp_stat_array.append([equipped_part.durability, equipped_part.color])
				list.set_item_custom_fg_color(list.get_item_count()-1,FontColorSettings.get_color(equipped_part.rarity)) #set color based on rarity
			list_index -= 1
		elif checked_part.size() > 0: #checks if the part exists in the players inventory
			for n in checked_part.size():
				temp_stat_array.append(checked_part[n])
				var part_name = temp_part.name
				part_name = part_name.replace(engine_name, "")
				list.add_item(part_name)
				list.set_item_custom_fg_color(list.get_item_count()-1,FontColorSettings.get_color(temp_part.rarity)) #set color based on rarity
				if engine.part_placeable(part_category, temp_part) == false or engine.size_check(part_category, temp_part) == false:
					print("Disable: ",part_name)
					list.set_item_disabled(temp_stat_array.size()-1, true)
		list_index += 1


func _process(_delta):
	if active == true:
		if instantiated == false:
			instantiate()
		if updated == true:
			updated = false
		if selected_tab == 6:
			slider_controller()
		if Input.is_action_just_pressed("ui_cancel"):
			_on_return_button_pressed()


func _on_block_button_pressed():
	button_sound.play()
	temp_array = specific_parts.block
	selected_tab = 0
	part_category = "block"
	equipped_part = engine.block #updates the equipped part
	populate_list()
	tab_changed()
func _on_internals_button_pressed():
	button_sound.play()
	temp_array = specific_parts.internals
	selected_tab = 1
	equipped_part = engine.internals #updates the equipped part
	part_category = "internals"
	populate_list()
	tab_changed()
func _on_top_button_pressed():
	button_sound.play()
	temp_array = specific_parts.top
	selected_tab = 2
	equipped_part = engine.top #updates the equipped part
	part_category = "top"
	populate_list()
	tab_changed()
func _on_exhaust_manifold_button_pressed():
	button_sound.play()
	temp_array = specific_parts.exhaust_manifold
	selected_tab = 3
	equipped_part = engine.exhaust_manifold #updates the equipped part
	part_category = "exhaust_manifold"
	populate_list()
	tab_changed()
func _on_intake_manifold_button_pressed():
	button_sound.play()
	temp_array = specific_parts.intake_manifold
	selected_tab = 4
	equipped_part = engine.intake_manifold #updates the equipped part
	part_category = "intake_manifold"
	populate_list()
	tab_changed()
func _on_air_filter_button_pressed():
	button_sound.play()
	temp_array = universal_parts.air_filter
	selected_tab = 5
	equipped_part = engine.air_filter #updates the equipped part
	part_category = "air_filter"
	populate_list()
	tab_changed()
func _on_tune_button_pressed():
	pass
	button_sound.play()
	list.clear()
	$"../Tune".show()
	boost_slider.value = engine.max_boost * 10
	rpm_slider.value = engine.max_rpm / 100
	selected_tab = 6
	tab_changed()

var temp_tab = selected_tab
func tab_changed():
	if temp_tab != selected_tab:
		if temp_tab == 6: #if tune
			update_engine()
			$"../Tune".hide()
		temp_tab = selected_tab
		return true


func _on_item_selected(index): #when a part in the item list is clicked (node signal)
	button_sound.play()
	#sets what type of part category is selected
	if specific_parts != null:
		match selected_tab:
			0:
				selected_part = specific_parts.block
			1:
				selected_part = specific_parts.internals
			2:
				selected_part = specific_parts.top
			3:
				selected_part = specific_parts.exhaust_manifold
			4:
				selected_part = specific_parts.intake_manifold
			5:
				selected_part = universal_parts.air_filter


		#for loop for finding the correct part
		if index == 1 and equipped_part.name != "[empty]":
			temp_part_select_part = equipped_part
		else:
			for i in selected_part.size():
				temp_part_select_part = selected_part[i].instantiate()
				if temp_part_select_part.get_name() == engine_name + list.get_item_text(index) or temp_part_select_part.get_name() == list.get_item_text(index): #if correct part by name
					break
				elif index == 0: #If empty part
					break
				temp_part_select_part.queue_free()
				i += 1
		
		#Updates stat tv
		temp_part_select_part.durability = temp_stat_array[index][0]
		temp_part_select_part.color = temp_stat_array[index][1]
		stats.change_part(temp_part_select_part, part_category)
		
		#sends update to engine that parts have changed
		match selected_tab:
			0:
				if index != 1 or (equipped_part.name == "[empty]" and index > 0):
					if engine.block.name != "[empty]":
						Save_Load.inv_add(engine.block)
					if temp_part_select_part.name != "[empty]":
						Save_Load.remove_inv(temp_part_select_part)
				
				engine.selected_block = temp_part_select_part.Part_Number
				engine.block_durability = temp_stat_array[index][0]
				update_engine()
				_on_block_button_pressed()
			1:
				if index != 1 or (equipped_part.name == "[empty]" and index > 0):
					if engine.internals.name != "[empty]":
						Save_Load.inv_add(engine.internals)
					if temp_part_select_part.name != "[empty]":
						Save_Load.remove_inv(temp_part_select_part)
						
				engine.selected_internals = temp_part_select_part.Part_Number
				engine.internals_durability = temp_stat_array[index][0]
				update_engine()
				_on_internals_button_pressed()
			2:
				if index != 1 or (equipped_part.name == "[empty]" and index > 0):
					if engine.top.name != "[empty]":
						Save_Load.inv_add(engine.top)
					if temp_part_select_part.name != "[empty]":
						Save_Load.remove_inv(temp_part_select_part)
						
				engine.selected_top = temp_part_select_part.Part_Number
				engine.top_durability = temp_stat_array[index][0]
				update_engine()
				_on_top_button_pressed()
			3:
				if index != 1 or (equipped_part.name == "[empty]" and index > 0):
					if engine.exhaust_manifold.name != "[empty]":
						Save_Load.inv_add(engine.exhaust_manifold)
					if temp_part_select_part.name != "[empty]":
						Save_Load.remove_inv(temp_part_select_part)
				
				engine.selected_exhaust_manifold = temp_part_select_part.Part_Number
				engine.exhaust_manifold_durability = temp_stat_array[index][0]
				update_engine()
				_on_exhaust_manifold_button_pressed()
			4:
				if index != 1 or (equipped_part.name == "[empty]" and index > 0):
					if engine.intake_manifold.name != "[empty]":
						Save_Load.inv_add(engine.intake_manifold)
					if temp_part_select_part.name != "[empty]":
						Save_Load.remove_inv(temp_part_select_part)
				
				engine.selected_intake_manifold = temp_part_select_part.Part_Number
				engine.intake_manifold_durability = temp_stat_array[index][0]
				update_engine()
				_on_intake_manifold_button_pressed()
			5:
				if index != 1 or (equipped_part.name == "[empty]" and index > 0):
					if engine.air_filter.name != "[empty]":
						Save_Load.inv_add(engine.air_filter)
					if temp_part_select_part.name != "[empty]":
						Save_Load.remove_inv(temp_part_select_part)
				
				engine.selected_air_filter = temp_part_select_part.Part_Number
				engine.air_filter_durability = temp_stat_array[index][0]
				update_engine()
				_on_air_filter_button_pressed()

func slider_controller():
	boost_text.text = str(float(boost_slider.value)/10.0) + "BAR"
	rpm_text.text = str(rpm_slider.value*100) + "RPM"
	engine.max_boost = float(boost_slider.value)/10.0
	engine.max_rpm = rpm_slider.value*100

func update_engine():
	engine.update_engine_parts()
	Save_Load.edit_engine(engine)
	if temp_tab != 6 and temp_part_select_part != null:
		$"../Description".text = temp_part_select_part.description


func _on_return_button_pressed():
	if active == true:
		active = false
		update_engine()
		$"../Tune".hide()
		$"../Car Edit Controller".active = true
		$"../Car Edit Controller".initiated = false
