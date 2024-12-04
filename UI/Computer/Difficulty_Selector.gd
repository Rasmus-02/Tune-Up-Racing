extends Control

func open():
	enable_disable()
	#Mark the button of selected difficulty from file as "toggled"
	match Settings.difficulty:
		0:
			select_new($Buttons/Beginner)
		1:
			select_new($Buttons/Easy)
		2:
			select_new($Buttons/Medium)
		3:
			select_new($Buttons/Hard)
		4:
			select_new($Buttons/Insane)


func _on_beginner_pressed():
	select_new($Buttons/Beginner)
	set_difficulty(0)

func _on_easy_pressed():
	select_new($Buttons/Easy)
	set_difficulty(1)

func _on_medium_pressed():
	select_new($Buttons/Medium)
	set_difficulty(2)

func _on_hard_pressed():
	select_new($Buttons/Hard)
	set_difficulty(3)

func _on_insane_pressed():
	select_new($Buttons/Insane)
	set_difficulty(4)



func set_difficulty(difficulty : int):
	Settings.difficulty = difficulty
	Settings.save_settings()

func select_new(button):
	var buttons = [$Buttons/Beginner, $Buttons/Easy, $Buttons/Medium, $Buttons/Hard, $Buttons/Insane]
	for i in range(buttons.size()):
		var test_button = buttons[i]
		#If not selected button and is on, turn off
		if test_button != button and test_button.button_pressed == true:
			test_button.button_pressed = false
		#turn on selected button if deselected
		elif test_button == button and test_button.button_pressed == false:
			test_button.button_pressed = true

#Will disable difficulties that aren't unlocked
func enable_disable():
	var level = Save_Load.level
	if level < 10:
		$Buttons/Easy.disabled = true
	else:
		$Buttons/Easy.disabled = false
	
	if level < 20:
		$Buttons/Medium.disabled = true
	else:
		$Buttons/Medium.disabled = false
	
	if level < 30:
		$Buttons/Hard.disabled = true
	else:
		$Buttons/Hard.disabled = false
	
	if level < 40:
		$Buttons/Insane.disabled = true
	else:
		$Buttons/Insane.disabled = false
