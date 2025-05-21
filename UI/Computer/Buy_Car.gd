extends Panel

#When "Yes" is pressed in buy popup
func buy_car(car, price):
	##Remove money from account
	Save_Load.money -= price
	
	##Setup car and engine keys
	var engine_key = Save_Load.largest_key("engine", null) + 1
	var car_key = Save_Load.largest_key("car", null) + 1
	#Setup car keys
	car.selected_engine = str(engine_key)
	car.selected_car_key = str(car_key)
	#Setup engine keys
	car.engine.selected_engine_key = str(engine_key)
	car.engine.in_car = car_key
	
	##Add engine for the car
	Save_Load.set_engine(car.engine)
	Save_Load.add_engine()
	#Add car
	car.in_garage = null #Set car to parking lot
	Save_Load.set_car(car)
	Save_Load.add_car()
	
	##Play sound
	Sound.buy.play()

