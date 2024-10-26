extends Label

@onready var car_edit = $"../Car Edit Controller"
@onready var engine_edit = $"../Engine Edit Controller"
@onready var spawner = $"../../Car_Spawner_Global"

func _process(_delta):
	if engine_edit.active == true:
		set_lift_car_name()
	else:
		set_engine_name()

var current_car_name = null
func set_lift_car_name():
	if spawner.lift_car != null and spawner.lift_car.get_children != null:
		if spawner.lift_car.get_child(0).get_children != null:
			if get_text() != spawner.lift_car.get_child(0).get_child(0).name:
				current_car_name = spawner.lift_car.get_child(0).get_child(0).name
				set_text(current_car_name)

var current_engine_name = null
func set_engine_name():
	if spawner.lift_car != null and spawner.lift_car.engine != null:
		if spawner.lift_car.engine.get_child(0).get_children != null:
			if get_text() != spawner.lift_car.engine.get_child(0).get_child(0).name:
				current_engine_name = spawner.lift_car.engine.get_child(0).get_child(0).name
				set_text(current_engine_name)
