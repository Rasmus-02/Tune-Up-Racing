extends Label

var displayed_money = 0

func _process(delta):
	#Nice effect makes money change smoothly
	if Save_Load.money != displayed_money:
		var difference = Save_Load.money - displayed_money
		if difference < -100:
			displayed_money *= 0.98
			difference = Save_Load.money - displayed_money
		if difference < 0:
			displayed_money -= 1
			difference = Save_Load.money - displayed_money
			
		if difference > 100:
			displayed_money *= 1.02
			difference = Save_Load.money - int(displayed_money)
		if difference > 0:
			displayed_money += 1
			difference = Save_Load.money - displayed_money
		
		text = format_number(int(displayed_money))+"$"

func format_number(num: int) -> String:
	var num_str = str(num)
	var result = ""
	var count = 0
	
	for i in range(num_str.length() - 1, -1, -1):
		result = num_str[i] + result
		count += 1
		if count % 3 == 0 and i != 0:
			result = "." + result  # Insert period as thousand separator
	
	return result
