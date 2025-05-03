extends Node2D

@onready var hp_line := $hp_line
@onready var hp_line_position = hp_line.global_position
@onready var tq_line := $tq_line
@onready var tq_line_position = tq_line.global_position


var hp = 0.0
var tq = 0.0
var max_tq = 0
var engine_rpm = 0.0
var max_engine_rpm = 0.0
signal dyno_status(dyno_status)



#Sends out signal to engine that it is on dyno
func _ready():
	emit_signal("dyno_status", 1)

func _process(_delta):
	if engine_rpm < max_engine_rpm:
		$hp_line/Label.text = str(int(hp))
		$hp_line/Label2.text = str(int(tq))
	if engine_rpm > 500 and engine_rpm < max_engine_rpm:
		hp_line_position.x = (float(engine_rpm) / float(max_engine_rpm))*(75*3) -75
		hp_line_position.x = clamp(hp_line_position.x, -75, 9999)
		hp_line_position.y = ((hp+0.001) / (max_tq *2)) * -50*2 #+0.001 to keep it a float
		hp_line_position.y = clamp(hp_line_position.y, -50*8, 50)
		hp_line.add_point(hp_line_position)
		
		tq_line_position.x = (float(engine_rpm) / float(max_engine_rpm))*(75*3) -75
		tq_line_position.x = clamp(tq_line_position.x, -75, 9999)
		tq_line_position.y = ((tq+0.001)/(max_tq*2)) * -50*2 #+0.001 to keep it a float
		tq_line_position.y = clamp(tq_line_position.y, -50*8, 50)
		tq_line.add_point(tq_line_position)


#Takes in variables from engine
func _on_engine_rpm_info(rpm, max_rpm):
	engine_rpm = rpm
	max_engine_rpm = max_rpm

func _on_engine_stats(horsepower, torque, max_torque, _fuel_type):
	hp = horsepower
	tq = torque
	max_tq = max_torque
