extends ItemList

@export var category_list : ItemList
@export var stats_tab : Panel
@export_enum("Buy", "Sell") var function : String
var part_list = []
var durability_list = []
var clicked = false
var selected_tab = "both"
var selected_category = "all"
var brakes_icon = [preload("res://Textures/UI/Car_Builder/Brakes_Icon_c.png"), preload("res://Textures/UI/Car_Builder/Brakes_Icon_uc.png"), preload("res://Textures/UI/Car_Builder/Brakes_Icon_r.png"), preload("res://Textures/UI/Car_Builder/Brakes_Icon_e.png"), preload("res://Textures/UI/Car_Builder/Brakes_Icon_l.png")]
var driveshaft_icon = [preload("res://Textures/UI/Car_Builder/Driveshaft_Icon_c.png"), preload("res://Textures/UI/Car_Builder/Driveshaft_Icon_uc.png"), preload("res://Textures/UI/Car_Builder/Driveshaft_Icon_r.png"), preload("res://Textures/UI/Car_Builder/Driveshaft_Icon_e.png"), preload("res://Textures/UI/Car_Builder/Driveshaft_Icon_l.png")]
var exhaust_icon = [preload("res://Textures/UI/Car_Builder/Exhaust_Icon_c.png"), preload("res://Textures/UI/Car_Builder/Exhaust_Icon_uc.png"), preload("res://Textures/UI/Car_Builder/Exhaust_Icon_r.png"), preload("res://Textures/UI/Car_Builder/Exhaust_Icon_e.png"), preload("res://Textures/UI/Car_Builder/Exhaust_Icon_l.png")]
var fenders_icon = [preload("res://Textures/UI/Car_Builder/Fenders_icon_c.png"), preload("res://Textures/UI/Car_Builder/Fenders_icon_uc.png"), preload("res://Textures/UI/Car_Builder/Fenders_icon_r.png"), preload("res://Textures/UI/Car_Builder/Fenders_icon_e.png"), preload("res://Textures/UI/Car_Builder/Fenders_icon_l.png")]
var f_bumper_icon = [preload("res://Textures/UI/Car_Builder/Front_Bumper_icon_c.png"), preload("res://Textures/UI/Car_Builder/Front_Bumper_icon_uc.png"), preload("res://Textures/UI/Car_Builder/Front_Bumper_icon_r.png"), preload("res://Textures/UI/Car_Builder/Front_Bumper_icon_e.png"), preload("res://Textures/UI/Car_Builder/Front_Bumper_icon_l.png")]
var r_bumper_icon = [preload("res://Textures/UI/Car_Builder/Rear_Bumper_icon_c.png"), preload("res://Textures/UI/Car_Builder/Rear_Bumper_icon_uc.png"), preload("res://Textures/UI/Car_Builder/Rear_Bumper_icon_r.png"), preload("res://Textures/UI/Car_Builder/Rear_Bumper_icon_e.png"), preload("res://Textures/UI/Car_Builder/Rear_Bumper_icon_l.png")]
var gearbox_icon = [preload("res://Textures/UI/Car_Builder/Gearbox_Icon_c.png"), preload("res://Textures/UI/Car_Builder/Gearbox_Icon_uc.png"), preload("res://Textures/UI/Car_Builder/Gearbox_Icon_r.png"), preload("res://Textures/UI/Car_Builder/Gearbox_Icon_e.png"), preload("res://Textures/UI/Car_Builder/Gearbox_Icon_l.png")]
var headlights_icon = [preload("res://Textures/UI/Car_Builder/Headlights_icon_c.png"), preload("res://Textures/UI/Car_Builder/Headlights_icon_uc.png"), preload("res://Textures/UI/Car_Builder/Headlights_icon_r.png"), preload("res://Textures/UI/Car_Builder/Headlights_icon_e.png"), preload("res://Textures/UI/Car_Builder/Headlights_icon_l.png")]
var taillights_icon = [preload("res://Textures/UI/Car_Builder/Taillights_icon_c.png"), preload("res://Textures/UI/Car_Builder/Taillights_icon_uc.png"), preload("res://Textures/UI/Car_Builder/Taillights_icon_r.png"), preload("res://Textures/UI/Car_Builder/Taillights_icon_e.png"), preload("res://Textures/UI/Car_Builder/Taillights_icon_l.png")]
var hood_icon = [preload("res://Textures/UI/Car_Builder/Hood_icon_c.png"), preload("res://Textures/UI/Car_Builder/Hood_icon_uc.png"), preload("res://Textures/UI/Car_Builder/Hood_icon_r.png"), preload("res://Textures/UI/Car_Builder/Hood_icon_e.png"), preload("res://Textures/UI/Car_Builder/Hood_icon_l.png")]
var mirrors_icon = [preload("res://Textures/UI/Car_Builder/Mirrors_icon_c.png"), preload("res://Textures/UI/Car_Builder/Mirrors_icon_uc.png"), preload("res://Textures/UI/Car_Builder/Mirrors_icon_r.png"), preload("res://Textures/UI/Car_Builder/Mirrors_icon_e.png"), preload("res://Textures/UI/Car_Builder/Mirrors_icon_l.png")]
var spoiler_icon = [preload("res://Textures/UI/Car_Builder/Spoiler_icon_c.png"), preload("res://Textures/UI/Car_Builder/Spoiler_icon_uc.png"), preload("res://Textures/UI/Car_Builder/Spoiler_icon_r.png"), preload("res://Textures/UI/Car_Builder/Spoiler_icon_e.png"), preload("res://Textures/UI/Car_Builder/Spoiler_icon_l.png")]
var subframe_icon = [preload("res://Textures/UI/Car_Builder/Subframe_Icon_c.png"), preload("res://Textures/UI/Car_Builder/Subframe_Icon_uc.png"), preload("res://Textures/UI/Car_Builder/Subframe_Icon_r.png"), preload("res://Textures/UI/Car_Builder/Subframe_Icon_e.png"), preload("res://Textures/UI/Car_Builder/Subframe_Icon_l.png")]
var suspension_icon = [preload("res://Textures/UI/Car_Builder/Suspension_Icon_c.png"), preload("res://Textures/UI/Car_Builder/Suspension_Icon_uc.png"), preload("res://Textures/UI/Car_Builder/Suspension_Icon_r.png"), preload("res://Textures/UI/Car_Builder/Suspension_Icon_e.png"), preload("res://Textures/UI/Car_Builder/Suspension_Icon_l.png")]
var tires_icon = [preload("res://Textures/UI/Car_Builder/Tires_Icon_c.png"), preload("res://Textures/UI/Car_Builder/Tires_Icon_uc.png"), preload("res://Textures/UI/Car_Builder/Tires_Icon_r.png"), preload("res://Textures/UI/Car_Builder/Tires_Icon_e.png"), preload("res://Textures/UI/Car_Builder/Tires_Icon_l.png")]
var wheels_icon = [preload("res://Textures/UI/Car_Builder/Wheels_Icon_c.png"), preload("res://Textures/UI/Car_Builder/Wheels_Icon_uc.png"), preload("res://Textures/UI/Car_Builder/Wheels_Icon_r.png"), preload("res://Textures/UI/Car_Builder/Wheels_Icon_e.png"), preload("res://Textures/UI/Car_Builder/Wheels_Icon_l.png")]
var radiator_icon = [preload("res://Textures/UI/Car_Builder/Radiator_Icon_c.png"), preload("res://Textures/UI/Car_Builder/Radiator_Icon_uc.png"), preload("res://Textures/UI/Car_Builder/Radiator_Icon_r.png"), preload("res://Textures/UI/Car_Builder/Radiator_Icon_e.png"), preload("res://Textures/UI/Car_Builder/Radiator_Icon_l.png")]
var airfilter_icon = [preload("res://Textures/UI/Engine_Builder/Airfilter_Icon_c.png"), preload("res://Textures/UI/Engine_Builder/Airfilter_Icon_uc.png"), preload("res://Textures/UI/Engine_Builder/Airfilter_Icon_r.png"), preload("res://Textures/UI/Engine_Builder/Airfilter_Icon_e.png"), preload("res://Textures/UI/Engine_Builder/Airfilter_Icon_l.png")]
var block_icon = [preload("res://Textures/UI/Engine_Builder/Block_Icon_c.png"), preload("res://Textures/UI/Engine_Builder/Block_Icon_uc.png"), preload("res://Textures/UI/Engine_Builder/Block_Icon_r.png"), preload("res://Textures/UI/Engine_Builder/Block_Icon_e.png"), preload("res://Textures/UI/Engine_Builder/Block_Icon_l.png")]
var exhaust_manifold_icon = [preload("res://Textures/UI/Engine_Builder/Exhaust_Manifold_Icon_c.png"), preload("res://Textures/UI/Engine_Builder/Exhaust_Manifold_Icon_uc.png"), preload("res://Textures/UI/Engine_Builder/Exhaust_Manifold_Icon_r.png"), preload("res://Textures/UI/Engine_Builder/Exhaust_Manifold_Icon_e.png"), preload("res://Textures/UI/Engine_Builder/Exhaust_Manifold_Icon_l.png")]
var intake_manifold_icon = [preload("res://Textures/UI/Engine_Builder/Intake_Manifold_Icon_c.png"), preload("res://Textures/UI/Engine_Builder/Intake_Manifold_Icon_uc.png"), preload("res://Textures/UI/Engine_Builder/Intake_Manifold_Icon_r.png"), preload("res://Textures/UI/Engine_Builder/Intake_Manifold_Icon_e.png"), preload("res://Textures/UI/Engine_Builder/Intake_Manifold_Icon_l.png")]
var internals_icon = [preload("res://Textures/UI/Engine_Builder/Internals_Icon_c.png"), preload("res://Textures/UI/Engine_Builder/Internals_Icon_uc.png"), preload("res://Textures/UI/Engine_Builder/Internals_Icon_r.png"), preload("res://Textures/UI/Engine_Builder/Internals_Icon_e.png"), preload("res://Textures/UI/Engine_Builder/Internals_Icon_l.png")]
var top_icon = [preload("res://Textures/UI/Engine_Builder/Top_Icon_c.png"), preload("res://Textures/UI/Engine_Builder/Top_Icon_uc.png"), preload("res://Textures/UI/Engine_Builder/Top_Icon_r.png"), preload("res://Textures/UI/Engine_Builder/Top_Icon_e.png"), preload("res://Textures/UI/Engine_Builder/Top_Icon_l.png")]
var engine_icons = [block_icon, exhaust_manifold_icon, intake_manifold_icon, internals_icon, top_icon, airfilter_icon]
var car_icons = ["", driveshaft_icon, fenders_icon, f_bumper_icon, headlights_icon, hood_icon, mirrors_icon, r_bumper_icon, subframe_icon, taillights_icon, spoiler_icon, brakes_icon, suspension_icon, tires_icon, wheels_icon, gearbox_icon, radiator_icon, exhaust_icon]
@export var highlighted_item_color : Color


func _ready():
	_on_both_tab_pressed()

var temp_hovered = null
func _process(_delta):
	#Manage the highlight system
	if true_hovered_item != null and stats_tab.status == "closed" and get_parent().visible == true:
		#Disable previous highlighted selection
		if temp_hovered != null and temp_hovered <= item_count:
			set_item_custom_bg_color(get_both_tabs(temp_hovered)[0], Color(0, 0, 0, 0))
			set_item_custom_bg_color(get_both_tabs(temp_hovered)[1], Color(0, 0, 0, 0))
		#Highlight new selection
		if true_hovered_item <= item_count and (get_selected_items().size() == 0 or (get_both_tabs(true_hovered_item)[0] != get_selected_items()[0] and get_both_tabs(true_hovered_item)[1] != get_selected_items()[0])):
			set_item_custom_bg_color(get_both_tabs(true_hovered_item)[0], highlighted_item_color)
			set_item_custom_bg_color(get_both_tabs(true_hovered_item)[1], highlighted_item_color)
		temp_hovered = true_hovered_item
	
	#This is used to make sure the green price text isn't ovewritten by the "Hover text color" in itemlist theme
	if temp_hovered != null and temp_hovered % 2 == 1:
		add_theme_color_override("font_hovered_color", Color(0, 0.69019609689713, 0))
	else:
		add_theme_color_override("font_hovered_color", Color(0.29019600152969, 0.29019600152969, 0.29019600152969))
	
	#For search function, so that if pressing enter it will search
	if $"../Top Tab/Search Bar".has_focus() and Input.is_action_just_pressed("ui_accept"):
		_on_search_button_pressed()

var hovered_item := -1
var true_hovered_item = null

func _input(event):
	if event is InputEventMouseMotion or InputEventMouseButton:
		var mouse_pos := get_local_mouse_position()
		var index := get_item_at_position(mouse_pos, true)
		if hovered_item != index:
			if index != null and index != -1: 
				true_hovered_item = index
			hovered_item = index
	if Input.is_action_just_pressed("ui_accept") and current_index == temp_index and has_focus():
		print("CHANGE INDEX")
		_on_item_selected(current_index)


func populate_list():
	temp_hovered = null
	true_hovered_item = null
	clear_list()
	var search_text = $"../Top Tab/Search Bar".text
	#IN SHOP
	if function == "Buy":
		part_list = AssetList.get_parts(selected_category, 5, null, search_text, "")
	#IN INVENTORY
	else:
		part_list = AssetList.get_parts(selected_category, 5, null, search_text, "Save")
	
	for i in part_list.size():
		var id = part_list[i].id[1]
		var rarity = 0
		#Durability is added to seperate list to find part with correct durability
		var durability = part_list[i].durability
		durability_list.append(durability)
		var price = str(part_list[i].price)
		if function == "Sell": 
			price = str(int(part_list[i].price * 0.8 * (float(durability) / 100.0)))
		
		match part_list[i].rarity: #Convert Rarity from string to int
			"common":
				rarity = 0
			"uncommon":
				rarity = 1
			"rare":
				rarity = 2
			"epic":
				rarity = 3
			"legendary":
				rarity = 4
		if part_list[i].type == 0: #if car
			add_item(part_list[i].name, car_icons[id][rarity]) #Find correct icon type and color
		else: #if engine
			add_item(part_list[i].name, engine_icons[id][rarity]) #Find correct icon type and color
		add_item("                  Price: "+ price+ "$")
		set_item_custom_fg_color(get_item_count()-1,Color(0, 0.69019609689713, 0))

func clear_list():
	clear()
	if part_list != null and part_list != []:
		for i in part_list:
			i.queue_free()
		part_list.clear()
		durability_list.clear()


func _on_search_button_pressed():
	populate_list()
func _on_car_tab_pressed():
	selected_tab = "car"
	selected_category = "car"
	category_list.clear()
	category_list.add_item("All Car Parts")
	category_list.add_car_categories()
	populate_list()
	#For toggling other buttons off
	$"../Top Tab/Engine_Tab".button_pressed = false
	$"../Top Tab/Both_Tab".button_pressed = false
func _on_engine_tab_pressed():
	selected_tab = "engine"
	selected_category = "engine"
	category_list.clear()
	category_list.add_item("All Engine Parts")
	category_list.add_engine_categories()
	populate_list()
	#For toggling other buttons off
	$"../Top Tab/Car_Tab".button_pressed = false
	$"../Top Tab/Both_Tab".button_pressed = false
func _on_both_tab_pressed():
	selected_tab = "both"
	selected_category = "all"
	category_list.clear()
	category_list.add_item("All Parts")
	category_list.add_car_categories()
	category_list.add_engine_categories()
	populate_list()
	#For toggling other buttons off
	$"../Top Tab/Engine_Tab".button_pressed = false
	$"../Top Tab/Car_Tab".button_pressed = false

func _on_part_categories_item_selected(index): #From Category list
	if index != 0: #if not "ALL ..." Tab
		selected_category = category_list.get_item_text(index)
	else:
		match selected_tab:
			"car":
				selected_category = "car"
			"engine":
				selected_category = "engine"
			"both":
				selected_category = "all"
	populate_list()


func get_selected_item(index):
	#Make it so if you press the right item (price) it ges index of left item (item)
	if index % 2 != 0:
		index -= 1
	
	var part_name = get_item_text(index)
	var durability = durability_list[index / 2] #every second item (because price is item)
	for i in part_list:
		if i.name == part_name and i.durability == durability:
			return i


func _on_item_clicked(index, _at_position, mouse_button_index): #To select the 2 tabs that make up 1 part
	if mouse_button_index == 1:
		#clicked = true
		_on_item_selected(index)

var temp_index = null
var current_index = null
func _on_item_selected(index):
	current_index = index
	select_mode = 1
	var tabs = get_both_tabs(index)
	select(tabs[0], false)
	select(tabs[1], false)
	select_mode = 0
	if index == temp_index: #For controller and mouse also uses it now
		stats_tab.selected_item = get_selected_item(index)
		stats_tab.open()
		release_focus()
	else:
		temp_index = index

func get_both_tabs(index): #Function for getting the correct 2 tabs
	if index == null:
		return [0,0]
	elif index % 2 == 0:
		return[index, index+1]
	else:
		return[index, index-1]
