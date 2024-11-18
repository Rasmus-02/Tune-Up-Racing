extends ItemList

var click_time = 0 #doubleclick timer thing
var temp_click_index = 0
var clicked = false
var temptab
@onready var car_editor = $"../Car Edit Controller"
@onready var engine_editor = $"../Engine Edit Controller"
@onready var description_animation = $"../../Props/Editor UI Description"

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("Interact"):
		if get_selected_items() != null and get_selected_items().size() == 1:
			_on_item_clicked(get_selected_items()[0], null, 1)
	
	#Make Engine Double clickable
	if get_selected_items().size() == 0 and car_editor.selected_tab == 0 and (car_editor.active or engine_editor.active) and temp_click_index <= item_count and has_focus():
		clicked = false
		select(temp_click_index, true)


func _on_item_clicked(index, at_position, mouse_button_index):
	if mouse_button_index == 1 and has_focus() and index <= item_count:
		clicked = true
		$"../Timer".start()
		click_time += 1
		if click_time > 1 and temp_click_index == index and car_editor.selected_tab == 0 and car_editor.active and index != 0: 
			car_editor.open_engine_editor()
		_on_item_selected(index)


func _on_item_selected(index):
	if clicked == true and has_focus():
		clicked = false
		description_animation.play("Update")
		if car_editor.active == true:
			car_editor._on_item_selected(index)
		elif engine_editor.active == true:
			engine_editor._on_item_selected(index)
		temp_click_index = index

func set_background_color(index):
	self.set_item_custom_bg_color(index,Color(0.73, 0.61, 0.32, 0.7))

func _on_timer_timeout():
	click_time = 0

