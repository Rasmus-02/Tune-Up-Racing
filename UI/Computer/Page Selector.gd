extends Control

@export var page_selector : Control
@export var page_shop : Control
@export var page_inventory : Control


func _on_back_button_pressed():
	print("PAGE CLOSE")
	close_pages()
	page_selector.show()

func close_pages():
	page_shop.hide()
	page_selector.hide()
	page_inventory.hide()

func _on_shop_button_pressed():
	close_pages()
	page_shop.show()

func _on_inventory_button_pressed():
	close_pages()
	page_inventory.show()
