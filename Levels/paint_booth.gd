extends Node2D
@export var buttons : Control
var active = false
var car
var selected_color = 0
var color_selector_active = false
var main = null

func _ready():
	main = get_tree().get_root().get_node("Main")
	select_color(0)
	close()

func _input(_event):
	if Input.is_action_just_released("ui_cancel") and active == true:
		if color_selector_active == false:
			close()
		else:
			color_selector_active = false

func open():
	car = get_parent().get_parent().get_node("Car_Spawner_Global").paint_car
	buttons.show()
	main.pause_blocked = true
	SelectedScene.scene = "edit"
	active = true

func close():
	active = false
	buttons.hide()
	SelectedScene.scene = "garage"
	main.pause_blocked = false

#Select a color (happends from paint card that gets spawned from paint system in player)
func select_color(color):
	selected_color = color
	var new_color = Colors.list[selected_color][0]
	self.material.set_shader_parameter("import_new_color", new_color)
	color_selector_active = false

#Opens paint selector in player
func _on_paint_selector_button_pressed():
	color_selector_active = true
	get_parent().get_parent().get_node("Player").get_child(0).get_node("Paint List").open()

#Call Painted function after a color has been applied to the car
var paint_sound_index = 0
func painted():
	var paint = [$Paint1, $Paint2, $Paint3, $Paint4, $Paint5]
	paint[paint_sound_index].play()
	paint_sound_index += 1
	if paint_sound_index > 4:
		paint_sound_index = 0
	car.update_car_parts()
	Save_Load.edit_car(car)

func _on_paint_all_pressed():
	car.chassi_color = selected_color
	car.f_bumper_color = selected_color
	car.r_bumper_color = selected_color
	car.fenders_color = selected_color
	car.hood_color = selected_color
	car.mirrors_color = selected_color
	car.headlights_color = selected_color
	car.taillights_color = selected_color
	car.spoiler_color = selected_color
	painted()

func _on_paint_chassi_pressed():
	car.chassi_color = selected_color
	painted()

func _on_paint_front_bumper_pressed():
	car.f_bumper_color = selected_color
	painted()

func _on_paint_rear_bumper_pressed():
	car.r_bumper_color = selected_color
	painted()

func _on_paint_fenders_pressed():
	car.fenders_color = selected_color
	painted()

func _on_paint_hood_pressed():
	car.hood_color = selected_color
	painted()

func _on_paint_mirrors_pressed():
	car.mirrors_color = selected_color
	painted()

func _on_paint_headlights_pressed():
	car.headlights_color = selected_color
	painted()

func _on_paint_taillights_pressed():
	car.taillights_color = selected_color
	painted()

func _on_paint_spoiler_pressed():
	car.spoiler_color = selected_color
	painted()
