extends Control

@export var page_selector : Control
@export var page_shop : Control
@export var page_inventory : Control
@export var pagename : Label


func _on_back_button_pressed():
	close_pages()
	page_selector.show()
	pagename.text = "https://gooble.com"

func close_pages():
	#Hide all pages
	page_shop.hide()
	page_selector.hide()
	page_inventory.hide()
	#Clear all lists
	page_shop.get_node("Parts").clear_list()
	page_inventory.get_node("Parts").clear_list()

func _on_shop_button_pressed():
	close_pages()
	page_shop.show()
	page_shop.get_node("Parts").populate_list()
	pagename.text = "https://carparts.net"

func _on_inventory_button_pressed():
	close_pages()
	page_inventory.show()
	page_inventory.get_node("Parts").populate_list()
	pagename.text = "http://localhost:8000"
