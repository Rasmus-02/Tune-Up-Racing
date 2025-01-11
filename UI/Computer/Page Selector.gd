extends Control

@export var page_selector : Control
@export var page_shop : Control
@export var page_inventory : Control
@export var page_difficulty : Control
@export var page_used_car_shop : Control
@export var pagename : Label
var pause_blocked = false
var selected_page = null


func _on_back_button_pressed():
	if pause_blocked == false:
		close_pages()
		page_selector.show()
		pagename.text = "https://gooble.com"
	elif selected_page != null:
		selected_page.back()

func close_pages():
	selected_page = null
	#Hide all pages
	page_shop.hide()
	page_selector.hide()
	page_inventory.hide()
	page_difficulty.hide()
	page_used_car_shop.hide()
	#Clear all lists
	page_shop.get_node("Parts").clear_list()
	page_inventory.get_node("Parts").clear_list()
	Utils.free_orphaned_nodes() #Free loaded orphan nodes

func _on_shop_button_pressed():
	close_pages()
	selected_page = page_shop
	page_shop.show()
	page_shop.get_node("Parts").populate_list()
	pagename.text = "https://carparts.net"

func _on_inventory_button_pressed():
	close_pages()
	selected_page = page_inventory
	page_inventory.show()
	page_inventory.get_node("Parts").populate_list()
	pagename.text = "https://inventory.manager.com"

func _on_difficulty_button_pressed():
	close_pages()
	selected_page = page_difficulty
	page_difficulty.show()
	page_difficulty.open()
	pagename.text = "https://localhost:8000"

func _on_used_car_shop_button_pressed():
	close_pages()
	selected_page = page_used_car_shop
	selected_page.get_node("Cars").get_node("List Of Cars").open()
	page_used_car_shop.show()
	pagename.text = "https://usedcars.net"
