extends Control

@export var extra_tab : Control

func back():
	extra_tab.close()
	unblock_pause()

func block_pause():
	get_parent().get_node("Page Selector").pause_blocked = true

func unblock_pause():
	get_parent().get_node("Page Selector").pause_blocked = false

func get_block_status():
	return get_parent().get_node("Page Selector").pause_blocked
