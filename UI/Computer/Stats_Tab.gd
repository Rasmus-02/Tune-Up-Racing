extends Panel

@export var part_list : ItemList
@onready var stat_text = $Stat_text
@onready var title = $Name
@onready var part = $"Display/Nagata Koi Stock Front Bumper"
@onready var part_position = $"Part Location"
@onready var price_label = $Price
@onready var popup = $"Part Confirmation Popup"
@export var not_enough_money_popup : Panel
@export var buy_sell_button : Button
var status = "closed"
var selected_item = null
var selected_color : int

#region Open / Close
func _input(_event): #Check only when a button is pressed
	if Input.is_action_pressed("ui_cancel"):
		close()
	#elif Input.is_action_just_pressed("ui_accept"):
	#	_on_buy_sell_button_pressed()

func open(): #open stats 
	status = "open"
	self.show()
	buy_sell_button.grab_focus()
	update_stats()

func close(): #close stats
	status = "closed"
	self.hide()
	release_focus()
	part_list.grab_focus()
#endregion


func update_stats():
	if selected_item != null: #Make sure no unavalible part is entered
		get_stats(selected_item, selected_item.id[1], selected_item.type) 
		#Add all the stats in correct order (ignore empty stats)
		var text_array = []
		for i in stats:
			if i[1] != null:
				text_array.append(str(i[0],": ",i[1],i[2])) #add stringified text to array
		var formatted_string = " " + str(text_array).replace(",", "\n").replace("[", "").replace("]", "").replace('"', "")
		stat_text.text = formatted_string
		
		stat_counter = 0 #reset stat counter because otherwise it would overflow after each new part
		stats = [null, null, null, null, null, null] #reset stats list
		update_title() #go to next state

func update_title():
	title.text = selected_item.name
	if popup.function == "Buy":
		price_label.text = "Price: " + str(selected_item.price) + "$"
	else: 
		price_label.text = "Price: " + str(int(selected_item.price * 0.8 * (float(selected_item.durability) / 100.0))) + "$"
	update_image() #go to next state

func update_image(): #add the part to the scene as an image
	var part_location = $"Display/Part Location"
	if part_location.get_child_count() != 0:
		part_location.remove_child(part_location.get_child(0))
	part_location.add_child(selected_item)
	#Set scale, position and rotation
	if selected_item.type == 0: #if Car set scale to 2x
		selected_item.global_scale = Vector2(0.5,0.5)
	elif selected_item.type == 1: #if Engine set scale to 4x because parts are smaller
		selected_item.global_scale = Vector2(1,1)
	selected_item.rotation = deg_to_rad(-90)
	#selected_item.position = $Display.position + Vector2(32,-230)
	selected_item.global_position = part_location.global_position
	$"Display/Lighting/Light Axis".global_position = part_location.global_position
	selected_item.z_index = 1
	#Change color
	selected_color = selected_item.color

#Function for getting the CORRECT stats to display in CORRECT order
#region Stat
var stats = [null, null, null, null, null, null]
var stat_counter = 0 #used to cycle through each stat successfully
func update_display(_row, value, stat_description, stat_type): #to refactor code taken from stats used for garage displays, adds into an array
	stats[stat_counter] = [stat_description, value, stat_type]
	stat_counter += 1

func get_stats(part, id : int, type : int):
#endregion
	match type:
		1:
			match id:
				#Engine
				0: #block
					update_display(stats[0], part.tq, "Torque", "Nm")
					update_display(stats[1], part.max_tq, "Max Torque", "Nm")
					update_display(stats[2], null, "", "")
					update_display(stats[3], null, "", "")
					update_display(stats[4], part.weight, "Weight", "Kg")
					update_display(stats[5], part.durability, "Durability", "%")
				3: #internals
					update_display(stats[0], part.compression, "Compression", ":1")
					update_display(stats[1], part.max_tq, "Max Torque", "Nm")
					update_display(stats[2], part.max_rpm, "Max RPM", "RPM")
					update_display(stats[3], null, "", "")
					update_display(stats[4], part.weight, "Weight", "Kg")
					update_display(stats[5], part.durability, "Durability", "%")
				4: #top
					update_display(stats[0], part.tq_mod * 100, "Efficiency", "%")
					update_display(stats[1], part.max_hp_rpm, "Peak RPM", "RPM")
					update_display(stats[2], part.max_compression, "Max Comp", ":1")
					update_display(stats[3], null, "", "")
					update_display(stats[4], part.weight, "Weight", "Kg")
					update_display(stats[5], part.durability, "Durability", "%")
				1: #exhaust manifold
					if part.turbo == true: #if turbo
						#("single", "twin", "sequential twin", "quad", "sequential quad") var turbo_type 
						var turbo
						match part.turbo_type:
							"single":
								turbo = "1 Turbo"
							"twin":
								turbo = "2 Turbos"
							"sequential_twin":
								turbo = "2seq Turbos"
							"quad":
								turbo = "4 Turbos"
							"sequential_quad":
								turbo = "4seq Turbos"
						update_display(stats[3], turbo, "Type", "")
						if part.turbo_type != "single":
							update_display(stats[1], part.turbo_1_size, "L Turbo", "mm")
							update_display(stats[2], part.turbo_2_size, "S Turbo", "mm")
						else:
							update_display(stats[1], part.turbo_1_size, "Turbo", "mm")
							update_display(stats[2], null, "", "")
						update_display(stats[0], (part.turbo_efficiency + part.tq_mod) * 50, "Efficiency", "%")
					else:
						update_display(stats[3], "NA", "Type", "")
						update_display(stats[1], null, "", "")
						update_display(stats[2], null, "", "")
						update_display(stats[0], part.tq_mod * 100, "Efficiency", "%")
					update_display(stats[4], part.weight, "Weight", "Kg")
					update_display(stats[5], part.durability, "Durability", "%")
				2: #intake manifold
					update_display(stats[0], part.tq_mod * 100, "Efficiency", "%")
					update_display(stats[1], part.max_compression_modifier * 100, "Max Comp", "%")
					if part.itb == true:
						update_display(stats[2], "ITB", "Type", "")
					elif part.supercharger == true:
						update_display(stats[2], "Supercharger", "Type", "")
					elif part.layout == "top":
						update_display(stats[2], "Carburator", "Type", "")
					else:
						update_display(stats[2], "EFI", "Type", "")
					if part.supercharger == true:
						update_display(stats[3], part.supercharer_displacement_capacity, "Capacity", "CC")
					else:
						update_display(stats[3], null, "", "")
					update_display(stats[4], part.weight, "Weight", "Kg")
					update_display(stats[5], part.durability, "Durability", "%")
				5: #Airfilter
					update_display(stats[0], part.tq_mod * 100, "Efficiency", "%")
					update_display(stats[1], null, "", "")
					update_display(stats[2], null, "", "")
					update_display(stats[3], null, "", "")
					update_display(stats[4], part.weight, "Weight", "Kg")
					update_display(stats[5], part.durability, "Durability", "%")
		0:
			match id:
				#Car
				3, 5, 4: #front bumper, hood, headlights
					update_display(stats[0], part.downforce, "Downforce", "Kg")
					update_display(stats[1], part.engine_cool_mod, "Cooling", "C°/s")
					update_display(stats[2], null, "", "")
					update_display(stats[3], part.drag, "Drag", "")
					update_display(stats[4], part.weight, "Weight", "Kg")
					update_display(stats[5], part.durability, "Durability", "%")
				7, 2, 6, 10: #rear bumper, fenders, mirrors, spoiler
					update_display(stats[0], part.downforce, "Downforce", "Kg")
					update_display(stats[1], null, "", "")
					update_display(stats[2], null, "", "")
					update_display(stats[3], part.drag, "Drag", "")
					update_display(stats[4], part.weight, "Weight", "Kg")
					update_display(stats[5], part.durability, "Durability", "%")
				9: #taillights
					update_display(stats[0], null, "", "")
					update_display(stats[1], null, "", "")
					update_display(stats[2], null, "", "")
					update_display(stats[3], null, "", "")
					update_display(stats[4], part.weight, "Weight", "Kg")
					update_display(stats[5], part.durability, "Durability", "%")
				12, 8: #suspension, subframe
					update_display(stats[0], int(part.handling_bonus * 100), "Handling", "%")
					update_display(stats[1], null, "", "")
					update_display(stats[2], null, "", "")
					update_display(stats[3], null, "", "")
					update_display(stats[4], part.weight, "Weight", "Kg")
					update_display(stats[5], part.durability, "Durability", "%")
				14: #wheels
					update_display(stats[0], part.brake_cooling, "Cooling", "C°/s")
					update_display(stats[1], null, "", "")
					update_display(stats[2], null, "", "")
					update_display(stats[3], null, "", "")
					update_display(stats[4], part.weight, "Weight", "Kg")
					update_display(stats[5], part.durability, "Durability", "%")
				13: #tires
					update_display(stats[0], int(part.grip * 0.1), "Traction", "%")
					update_display(stats[1], int(part.treadwear * 10000), "Treadwear", "")
					update_display(stats[2], null, "", "")
					update_display(stats[3], null, "", "")
					update_display(stats[4], part.weight, "Weight", "Kg")
					update_display(stats[5], part.durability, "Durability", "%")
				11: #brakes
					update_display(stats[0], int(part.brake_force * 14), "Braking", "N")
					update_display(stats[1], part.brake_cooling, "Cooling", "C°/s")
					update_display(stats[2], part.brake_fade_limit, "Fade @", "C°")
					update_display(stats[3], null, "", "")
					update_display(stats[4], part.weight, "Weight", "Kg")
					update_display(stats[5], part.durability, "Durability", "%")
				1: #driveshaft
					match part.drivetrain:
						0:
							update_display(stats[0], "RWD", "Type", "")
						1:
							update_display(stats[0], "FWD", "Type", "")
						2:
							update_display(stats[0], "AWD", "Type", "")
						
					update_display(stats[1], part.max_torque, "Max Torque", "Nm")
					update_display(stats[2], part.drivetrain_loss, "Power Loss", "%")
					update_display(stats[3], null, "", "")
					update_display(stats[4], part.weight, "Weight", "Kg")
					update_display(stats[5], part.durability, "Durability", "%")
				15: #gearbox
					match part.drivetrain:
						0:
							update_display(stats[0], "RWD", "Type", "")
						1:
							update_display(stats[0], "FWD", "Type", "")
						2:
							update_display(stats[0], "AWD", "Type", "")
						
					update_display(stats[1], part.max_tq, "Max Torque", "Nm")
					update_display(stats[2], part.gear_ratio.size() - 1, "Gears", "")
					update_display(stats[3], part.shift_time, "Shift Speed", "s")
					update_display(stats[4], part.weight, "Weight", "Kg")
					update_display(stats[5], part.durability, "Durability", "%")
				16: #radiator
					update_display(stats[0], part.cooling, "Cooling", "C°/s")
					update_display(stats[1], null, "", "")
					update_display(stats[2], null, "", "")
					update_display(stats[3], null, "", "")
					update_display(stats[4], part.weight, "Weight", "Kg")
					update_display(stats[5], part.durability, "Durability", "%")
				17: #exhaust
					update_display(stats[0], (part.tq_mod * 100), "Efficiency", "%")
					update_display(stats[1], part.sound_dampening, "Dampening", "dB")
					update_display(stats[2], null, "", "")
					update_display(stats[3], null, "", "")
					update_display(stats[4], part.weight, "Weight", "Kg")
					update_display(stats[5], part.durability, "Durability", "%")

func _on_exit_button_pressed():
	close()

func _on_buy_sell_button_pressed():
	if popup.function == "Buy":
		if selected_item.price <= Save_Load.money:
			popup.open()
		else:
			not_enough_money_popup.open()
	else:
		popup.open()
