extends VBoxContainer

@export var page_number_label : Label
@export var brand : OptionButton
@export var fuel_type : OptionButton
@export var gearing : OptionButton
@export var drive_type : OptionButton
@export var min_price : SpinBox
@export var max_price : SpinBox
@export var min_weight : SpinBox
@export var max_weight : SpinBox
@export var min_tq : SpinBox
@export var max_tq : SpinBox
var page_number = 1
var on_last_page = false

##THE Listing object for a car
var car_display = preload("res://UI/Computer/Used_Car_Shop_Car_Item.tscn")

func open():
	CarMarket.update_events()
	populate_page(1)

#Populate a page with as many cars as are on that page
func populate_page(page):
	#Set page number label
	page_number_label.text = str(page_number)
	for child in get_children():
		remove_child(child)
	Utils.free_orphaned_nodes() #Free loaded orphan nodes
	
	## Update the car list
	var car_list = CarMarket.car_list.duplicate() #duplicate to prevent the original list from getting changed
	car_list = filter_list(car_list)
	
	## GET MAX CARS THAT FIT ON THE PAGE
	var max_car : int
	#If Can fill out page with 5 Cars
	if page * 5 <= car_list.size():
		max_car = 5
		on_last_page = false
		#If it exactly meats list size, there should not be any new page
		if page * 5 == car_list.size():
			on_last_page = true
	#If Can't fill out page with 5 Cars
	elif page * 5 > car_list.size():
		max_car = car_list.size()  - ((page-1) * 5)
		on_last_page = true
	## ==================================
	var key_array = []
	for key in car_list.keys():
		key_array.append(key)
	
	##Add each of the cars
	var offset = (page - 1) * 5
	for car_index in max_car:
		var index = offset + car_index
		var listing = car_display.instantiate()
		var car = car_list.get(str(key_array[index]))
		add_child(listing)
		listing.load_car(car)
	
	key_array.clear()

func clear_page():
	for listing in get_children():
		listing.car_node.delete_car()


var filters = ["Any", "Any", "Any", "Any", [0, 99999999], [0, 99999999], [0, 99999999]]
func update_filters():
	var brand_filter = brand.get_item_text(brand.get_selected_id())
	var fuel_type_filter = fuel_type.get_item_text(fuel_type.get_selected_id())
	var gearing_filter = gearing.get_item_text(gearing.get_selected_id())
	var drive_type_filter = str(drive_type.get_selected_id() - 1)
	if drive_type.get_selected_id() == 0:
		drive_type_filter = "Any"
	var price_filter = [min_price.value, max_price.value]
	var weight_filter = [min_weight.value, max_weight.value]
	var tq_filter = [min_tq.value, max_tq.value]
	
	filters = [brand_filter, fuel_type_filter, gearing_filter, drive_type_filter,
	price_filter, weight_filter, tq_filter]


func filter_list(list):
	for key in list.keys():
		if list.get(str(key)) != null:
			var car = list.get(str(key)).car
			var engine = list.get(str(key)).engine
			#If statements for each filter (REMOVE CARS THAT DON'T MEET FILTER REQUIREMENTS)
			
			#Brand
			var car_name = AssetList.car_list.get_child(car.Car_ID + 1).name
			if filters[0] != "Any" and not car_name.contains(filters[0]):
				list.erase(key)
			#Fuel type
			elif filters[1] != "Any" and not engine.fuel_type.contains(filters[1]):
				list.erase(key)
			#Gearbox type
			elif filters[2] != "Any" and not car.gearbox_type.contains(filters[2]):
				list.erase(key)
			#Drivetrain type
			elif filters[3] != "Any" and not str(car.drivetrain).contains(filters[3]):
				list.erase(key)
			#Price
			elif filters[4][1] > 0 and (filters[4][0] > list.get(str(key)).price or filters[4][1] < list.get(str(key)).price):
				list.erase(key)
			#Weight
			elif filters[5][1] > 0 and (filters[5][0] > car.weight + engine.weight or filters[5][1] < car.weight + engine.weight):
				list.erase(key)
			#Torque
			elif filters[6][1] > 0 and (filters[6][0] > engine.Tq * car.drivetrain_loss or filters[6][1] < engine.Tq * car.drivetrain_loss -1):
				list.erase(key)
			#Favorited
			elif favorites == true and list.get(str(key)).favorite_status == false:
				list.erase(key)
	return list



func _on_next_pressed():
	if on_last_page == false:
		page_number += 1
		populate_page(page_number)

func _on_previous_pressed():
	if page_number > 1: #Make it so impossible to ge bellow 1
		page_number -= 1
		populate_page(page_number)

func _on_apply_pressed():
	update_filters()
	page_number = 1
	populate_page(1)

var favorites
func _on_favorites_pressed():
	$"../../Top Page Panel/ViewSelector/Car Finder".button_pressed = false
	$"../../Top Page Panel/ViewSelector/Favorites".button_pressed = true
	favorites = true
	page_number = 1
	populate_page(1)


func _on_car_finder_pressed():
	$"../../Top Page Panel/ViewSelector/Car Finder".button_pressed = true
	$"../../Top Page Panel/ViewSelector/Favorites".button_pressed = false
	favorites = false
	if get_parent().get_parent().get_block_status() == false: #If not in car detailed view
		page_number = 1
		populate_page(1)
