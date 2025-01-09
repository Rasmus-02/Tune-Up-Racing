extends CharacterBody2D

@export var movement_speed: int
@onready var car_garage_ui = $"../Interact_Menu_Garage"
@onready var footsteps = $Footsteps
var ui_visible = false
var in_controll = false
var selected_car = null
var interaction_object = null
var garage = null
var car_list
@onready var sprite = $AnimatedSprite2D
@onready var animation = $AnimationPlayer
@export var not_functional : AnimationPlayer
var main = null

func _ready():
	$Camera2D.make_current()
	main = get_tree().get_root().get_node("Main")
	garage = get_parent().get_parent()

func _physics_process(_delta):
	movement()
	disable_enable()
	interact()
	animation_handler()

func movement():
	var speed = movement_speed
	#Camera
	var t = 0.05 #Smoothing between mouse and player
	if selected_car != null and (SelectedScene.scene == "edit" or ui_visible == true):
		#Smoothly pan over camera to car
		$Camera2D.global_position.x = move_toward($Camera2D.global_position.x, selected_car.global_position.x, 0.01 * abs($Camera2D.global_position.x-selected_car.global_position.x))
		$Camera2D.global_position.y = move_toward($Camera2D.global_position.y, selected_car.global_position.y, 0.01 * abs($Camera2D.global_position.y-selected_car.global_position.y))
	else:
		$Camera2D.global_position.x = move_toward($Camera2D.global_position.x, $AnimatedSprite2D.global_position.x, 0.5)
		$Camera2D.global_position.y = move_toward($Camera2D.global_position.y, $AnimatedSprite2D.global_position.y, 0.5)
	
	if in_controll: #If character is controlled by player
		#Sprint
		if Input.is_action_pressed("Run"):
			speed = movement_speed * 1.5
		
		#Movement
		var direction = Input.get_vector("Left","Right","up","down")
		if direction:
			var max_velocity = direction * speed * direction.length()
			velocity.x = move_toward(velocity.x, max_velocity.x, 13)
			velocity.y = move_toward(velocity.y, max_velocity.y, 13)
		else:
			velocity.x = move_toward(velocity.x, 0, 10)
			velocity.y = move_toward(velocity.y, 0, 10)
		
		move_and_slide()
		
		#Rotation
		if velocity.length() > 0:
			var current_rot = $AnimatedSprite2D.rotation
			$AnimatedSprite2D.rotation = lerp_angle(current_rot, velocity.angle() + deg_to_rad(90), 3*t)
			$CollisionShape2D.rotation = velocity.angle()
	else:
		velocity = Vector2.ZERO


func animation_handler():
	if velocity.length() > 0:
		animation.play("Walk")
		if footsteps.playing == false:
			footsteps.play()
		
		animation.speed_scale = velocity.length() / 120
	else:
		animation.play("Idle")
		if footsteps.playing == true:
			footsteps.stop()
		animation.speed_scale = .2


func disable_enable(): #For disabling movement input
	if (SelectedScene.scene == "garage" or SelectedScene.scene == "parking_garage") and ui_visible == false:
		in_controll = true
	else:
		in_controll = false


func _on_selector_body_entered(body): #Select car in range
	if body.is_in_group("Car"):
		selected_car = body
func _on_selector_body_exited(body): #Deselect car when out of range
	if body.is_in_group("Car"):
		selected_car = null

func _on_selector_area_entered(area): #Select Object in range such as computer
	if area.is_in_group("Computer"):
		interaction_object = area
func _on_selector_area_exited(area): #Deselect Object when not in range
	if area.is_in_group("Computer"):
		interaction_object = null


#Interaction with car from player character
func interact():
	#Make Car Edit options appear 
	if selected_car != null and Input.is_action_just_pressed("Interact"):
		#If UI is already open close it
		if ui_visible == true:
			hide_ui()
		else:
			show_ui()
	elif selected_car != null and Input.is_action_just_pressed("ui_cancel") and ui_visible == true:
		if ui_visible == true:
			hide_ui()
	
	elif interaction_object != null and Input.is_action_just_pressed("Interact"):
		interaction_object.get_parent().interact()
		ui_visible = true

func stop_interacting():
	interaction_object.get_parent().exit()
	ui_visible = false

func hide_ui():
	car_garage_ui.hide()
	$"../Move_Menu".hide()
	ui_visible = false

func show_ui():
	if SelectedScene.scene != "garage" and SelectedScene.scene != "edit" or (get_parent().get_parent().get_node("Car Edit UI").get_node("Car Edit Controller").active == false and get_parent().get_parent().get_node("Car Edit UI").get_node("Engine Edit Controller").active == false and get_parent().get_parent().get_node("Props").get_node("Paint Booth").active == false):
		#set position where the us should spawn
		$"../Interact_Menu_Garage".global_position = selected_car.global_position +Vector2(-75,55)
		#reset which buttons are visible
		for n in car_garage_ui.get_child_count():
			car_garage_ui.get_child(n).hide()
		#select what menues should be visible
		$"../Interact_Menu_Garage/Drive_Car_button".show()
		$"../Interact_Menu_Garage/Move_Car_button".show()
		$"../Interact_Menu_Garage/Sell_Car_button".show()
		$"../Interact_Menu_Garage/Info_Car_button".hide() #NOT YET IMPLEMENTED
		if selected_car.in_garage == 1:
			$"../Interact_Menu_Garage/Edit_Car_button".show()
		if selected_car.in_garage == 2:
			$"../Interact_Menu_Garage/Dyno_button".show()
		if selected_car.in_garage == 3:
			$"../Interact_Menu_Garage/Paint_Car_button".show()
		car_garage_ui.show()
		$"../Interact_Menu_Garage/Drive_Car_button".grab_focus()
		ui_visible = true

func _on_edit_car_button_pressed():
	Save_Load.selected_car_key = selected_car.selected_car_key
	Save_Load.save()
	get_parent().get_parent().get_node("Car Edit UI").get_node("Car Edit Controller").initiated = false
	get_parent().get_parent().get_node("Car Edit UI").get_node("Car Edit Controller").active = true
	ui_visible = false
	car_garage_ui.hide()

func _on_dyno_button_pressed():
	if selected_car != null and selected_car.is_functional() and selected_car.engine.is_functional():
		Save_Load.selected_car_key = selected_car.selected_car_key
		Save_Load.save()
		get_parent().get_parent().get_node("Props").get_node("Dyno").update()
		selected_car.loaded = true
		selected_car.run_dyno()
		ui_visible = false
		car_garage_ui.hide()
	else:
		not_functional.play("play")

func _on_paint_car_button_pressed():
	if selected_car != null:
		Save_Load.selected_car_key = selected_car.selected_car_key
		Save_Load.save()
		get_parent().get_parent().get_node("Props").get_node("Paint Booth").open()
		ui_visible = false
		car_garage_ui.hide()


func _on_drive_car_button_pressed():
	if selected_car != null and selected_car.is_functional() and selected_car.engine.is_functional():
		Save_Load.selected_car_key = selected_car.selected_car_key
		Save_Load.save()
		garage.drive()
	else:
		not_functional.play("play")

func _on_info_car_button_pressed():
	pass # Replace with function body.

func _on_move_car_button_pressed():
	var move_menu = $"../Move_Menu"
	if selected_car != null:
		selected_car.loaded = false
		move_menu.show()
		move_menu.global_position = selected_car.global_position +Vector2(-100,55)
		##Set which menus should be visible in what scenese
		if SelectedScene.scene == "garage":
			move_menu.get_node("Move_Menu_Garage").show()
			move_menu.get_node("To Parking Garage").show()
			move_menu.get_node("From Parking Garage").hide()
		elif SelectedScene.scene == "parking_garage":
			move_menu.get_node("Move_Menu_Garage").hide()
			move_menu.get_node("To Parking Garage").hide()
			move_menu.get_node("From Parking Garage").show()
		ui_visible = true
		car_garage_ui.hide()
		$"../Move_Menu/Move_Menu_Garage/Left/Move_To_Lift".grab_focus()

func _on_sell_car_button_pressed():
	if selected_car != null:
		main.get_node("Sell_Menu").open(selected_car)
		ui_visible = false
		car_garage_ui.hide()


func check_if_movable(place):
	car_list = Save_Load.load_file("cars")
	var car_list_array = car_list.keys()
	for i in car_list.size():
		if place == car_list.get(car_list_array[i]).get("in_garage"):
			return false

func _on_move_to_lift_pressed():
	if check_if_movable(1) != false and selected_car.selected_car_key != null:
		selected_car.in_garage = 1
		save()
		move_car()

func _on_move_to_dyno_pressed():
	if check_if_movable(2) != false and selected_car.selected_car_key != null:
		selected_car.in_garage = 2
		save()
		move_car()

func _on_move_to_paint_pressed():
	if check_if_movable(3) != false and selected_car.selected_car_key != null:
		selected_car.in_garage = 3
		save()
		move_car()

func _on_move_to_garage_parking_1_pressed():
	if check_if_movable(4) != false and selected_car.selected_car_key != null:
		selected_car.in_garage = 4
		save()
		move_car()

func _on_move_to_garage_parking_2_pressed():
	if check_if_movable(5) != false and selected_car.selected_car_key != null:
		selected_car.in_garage = 5
		save()
		move_car()

func _on_move_to_garage_parking_3_pressed():
	if check_if_movable(6) != false and selected_car.selected_car_key != null:
		selected_car.in_garage = 6
		save()
		move_car()


func save():
	var key = selected_car.selected_car_key
	Save_Load.temp_key_car = key #car key
	Save_Load.edit_car(selected_car)
	Save_Load.save()

func move_car():
	if selected_car != null:
		get_parent().get_parent().get_node("Car_Spawner_Global").move_car(selected_car)
		selected_car.running_dyno = 0
		car_garage_ui.hide()
		$"../Move_Menu".hide()
		ui_visible = false

func get_empty_garage_slot():
	var free_spawn_positions = {"1" : 1, "2" : 2, "3" : 3, "4" : 4, "5" : 5, "6" : 6}
	if Save_Load.load_file("cars") != null:
		for n in Save_Load.load_file("cars"):
			var car_to_check = Save_Load.load_file("cars").get(str(n))
			if car_to_check != null and car_to_check.in_garage != null and car_to_check.in_garage > 0: #look trough each car in dictionary
				free_spawn_positions.erase(str(car_to_check.in_garage))
	
	if free_spawn_positions.keys().size() > 0:
		return(free_spawn_positions.get(free_spawn_positions.keys()[0]))
	else:
		return null

func _on_from_parking_garage_pressed():
	if selected_car != null:
		if get_empty_garage_slot() != null:
			selected_car.in_garage = get_empty_garage_slot()
			save()
			selected_car.queue_free()
			$"../Move_Menu".hide()
			ui_visible = false

func _on_to_parking_garage_pressed():
		if selected_car != null:
			selected_car.in_garage = null
			save()
			selected_car.queue_free()
			$"../Move_Menu".hide()
			ui_visible = false
