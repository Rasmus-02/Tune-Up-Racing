extends Control

var player_level : int
var xp_reward = 0
var money_reward = 0
var xp_to_add = 0
var money_to_add = 0
var event_queue = []
var event_finnished = true
var queue_position = 0
@export var race_results : Control
@export var level_up : Control
@export var map_viewport : Viewport
enum panels {RACEREWARD_1, RACEREWARD_2, LEVELUP_1, LEVELUP_2}
var selected_panel = 0
var paused = true

func open():
	self.show()
	event_queue.append(panels.RACEREWARD_1)
	player_level = Save_Load.level
	paused = false

func race_reward():
	#Baseline
	var money = 150.0
	var xp = 2500.0
	#Add player level bonuses
	money += Save_Load.level * 50 # 50$ more per level
	xp += Save_Load.level * 150 # 150 more per level
	#Add bonuses based on car stats
	money *= RaceStatus.reward_bonus
	xp *= RaceStatus.reward_bonus
	#Bonus for doing good
	var max_position = Placing.placing_list.size()
	var penalty = 1.0 - (float(RaceStatus.player_position) / float(max_position))
	money *= penalty
	xp *= penalty
	#Bonus for lap count and race track
	var lenght_bonus = ((float(Placing.max_lap) * float(Placing.map_bonus)) / 3) ** 0.8 #Baseline laps is 3, **0.8 to reduce effect of difference
	money *= lenght_bonus
	xp *= lenght_bonus
	#Bonus for Difficulty
	money *= Settings.get_difficulty_bonus("Money Bonus") 
	xp *= Settings.get_difficulty_bonus("Xp Bonus") 
	#Set the rewards
	money_reward = int(money)
	xp_reward = int(xp)


func _process(_delta):
	if paused == false:
		queue_handler()
		level_handler()
	elif RaceStatus.finished == true: #If race is finnished, (get status from global variable that gets updated in finnishline)
		open()

	#Smootly adds xp to xp bar and money
	if xp_to_add != 0:
		var xp = xp_reward * 0.005
		if xp <= xp_to_add:
			Save_Load.xp += int(xp)
			xp_to_add -= xp
		else:
			Save_Load.xp += int(xp_to_add)
			xp_to_add = 0
		if xp_to_add <= 0:
			race_results.get_node("Total").get_node("XP").save_pause = false
	
	#Smootly adds money
	if money_to_add != 0:
		var money = money_reward * 0.005
		if money <= money_to_add:
			Save_Load.money += int(money)
			money_to_add -= money
		else:
			Save_Load.money += int(money_to_add)
			money_to_add = 0

#If level up queue reward
func level_handler():
	if Save_Load.level > player_level:
		player_level += 1
		event_queue.append(panels.LEVELUP_1)

func queue_handler(): #Starts queue items
	if event_finnished == true and queue_position < event_queue.size():
		match event_queue[queue_position]:
			#Race Reward
			panels.RACEREWARD_1:
				event_finnished = false
				race_reward() # UPDATE REWARDS GIVEN FOR COMPLETING RACE
				var label = str(RaceStatus.player_position)
				var description = "You got " + get_position_title(RaceStatus.player_position)
				reward_1(race_results, panels.RACEREWARD_1, label, description)
			#Level Up
			panels.LEVELUP_1:
				event_finnished = false
				# UPDATE THE REWARDS GIVEN FOR LEVEL UP
				xp_reward = 0
				if int(Save_Load.level) % 10 != 0: #If not level up to 10, 20, 30 or 40
					money_reward = 250 * Save_Load.level
				else:
					money_reward = 1000 * Save_Load.level #If level up to 10, 20, 30 or 40
				# =====================================
				var label = str(Save_Load.level)
				var description = "Level Up!"
				reward_1(level_up, panels.LEVELUP_1, label, description)
	
	#If at end of queue change scene to garage
	if queue_position == event_queue.size():
		event_queue.clear()
		# Before changing to garage, make car player to save damage to car properly in car.gd
		map_viewport.get_child(0).get_node("Player").get_child(0).player = true
		# Change scene to garage
		var main = get_tree().get_root().get_node("Main")
		main.change_scene("garage")

func _input(_event):
	if Input.is_action_just_pressed("ui_accept"):
		match selected_panel:
			#Reward
			panels.RACEREWARD_1:
				reward_2(race_results, panels.RACEREWARD_2)
			panels.RACEREWARD_2:
				queue_position += 1
				event_finnished = true
				race_results.hide()
			#Level
			panels.LEVELUP_1:
				reward_2(level_up, panels.LEVELUP_2)
			panels.LEVELUP_2:
				queue_position += 1
				event_finnished = true
				level_up.hide()

func reward_1(tab, panel, label, description):
	tab.show()
	selected_panel = panel
	tab.get_node("Earned").show() #Show the earned rewards
	tab.get_node("Total").hide() #Hide the players total xp and money with the new added
	tab.get_node("Earned").update_text(xp_reward, money_reward, label, description)

func reward_2(tab, panel):
	selected_panel = panel
	tab.get_node("Earned").hide() #Hide the earned rewards
	tab.get_node("Total").show() #Show the players total xp and money with the new added
	#Add the rewards to the player
	var xp = tab.get_node("Total").get_node("XP")
	var money = tab.get_node("Total").get_node("Money")
	add_money_and_xp(xp, money)

func add_money_and_xp(xp , money):
	xp.save_pause = true #Pause saving to animate xp going up
	money.displayed_money = Save_Load.money
	xp_to_add = xp_reward #Adds the xp and money to the player
	money_to_add = money_reward #Adds the xp and money to the player
	Save_Load.money += int(money_reward)

func get_position_title(pos):
	match pos:
		1:
			return "1st place"
		2:
			return "2nd place"
		3:
			return "3rd place"
		4:
			return "4th place"
		5:
			return "5th place"
		6:
			return "6th place"
		7:
			return "7th place"
		8:
			return "last place"
