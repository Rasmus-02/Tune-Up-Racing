extends VBoxContainer

@export var page_number_label : Label
var page_number = 1
var on_last_page = false

##THE Listing object for a car
var car_display = preload("res://UI/Computer/Used_Car_Shop_Car_Item.tscn")

func _ready():
	populate_page(page_number)

#Populate a page with as many cars as are on that page
func populate_page(page):
	#Set page number label
	page_number_label.text = str(page_number)
	for child in get_children():
		remove_child(child)
	
	## GET MAX CARS THAT FIT ON THE PAGE
	var max_car : int
	#If Can fill out page with 5 Cars
	if page * 5 <= CarMarket.car_list.size():
		max_car = 5
		on_last_page = false
		#If it exactly meats list size, there should not be any new page
		if page * 5 == CarMarket.car_list.size():
			on_last_page = true
	#If Can't fill out page with 5 Cars
	elif page * 5 > CarMarket.car_list.size():
		max_car = CarMarket.car_list.size()  - ((page-1) * 5)
		on_last_page = true
	## ==================================
	var key_array = []
	for key in CarMarket.car_list.keys():
		key_array.append(key)
	
	##Add each of the cars
	var offset = (page - 1) * 5
	for car_index in max_car:
		var index = offset + car_index
		var listing = car_display.instantiate()
		var car = CarMarket.car_list.get(str(key_array[index]))
		add_child(listing)
		listing.load_car(car)
	
	key_array.clear()

func clear_page():
	for listing in get_children():
		listing.car_node.delete_car()

func _on_next_pressed():
	if on_last_page == false:
		page_number += 1
		populate_page(page_number)

func _on_previous_pressed():
	if page_number > 1: #Make it so impossible to ge bellow 1
		page_number -= 1
		populate_page(page_number)
