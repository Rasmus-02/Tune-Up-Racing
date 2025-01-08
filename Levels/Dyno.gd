extends Sprite2D

@onready var tq_line = $tq_line
@onready var hp_line = $hp_line
@onready var hp_text = $hp_line/hp
@onready var tq_text = $tq_line/tq
@onready var max_tq_text = $tq_line/max_tq
@onready var max_hp_text = $hp_line/max_hp
@onready var boost_text = $boost
@onready var rpm_text = $rpm
@onready var knock_text = $Knock
@onready var front_wheels = $Front_Wheels
@onready var rear_wheels = $Rear_Wheels

var car = null
var hp = 0
var tq = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	update()

func update():
	car = $"../../Car_Spawner_Global".dyno_car
	knock_text.hide()
	tq_line.clear_points()
	hp_line.clear_points()
	temp_hp = 0.0
	temp_tq = 0.0
	temp_rpm = 0
	delay = 0


func _process(_delta):
	if car != null and car.is_functional() and car.engine.is_functional():
		spin_rollers()
		plot_graphs_and_figures()
		display_peak_figures()


var temp_rpm = 0
var delay = 0
func plot_graphs_and_figures():
	delay += 1
	if car.engine_rpm > temp_rpm and car.engine.is_running and delay > 3 and car.gear == 3 and car.shift_cooldown == false:
		delay = 0
		temp_rpm=car.engine_rpm
		tq = car.max_engine_power
		hp = (car.max_engine_power * car.engine_rpm) / 7127
		var max_tq = car.engine.estimate_torque().tq * (1 - car.drivetrain_loss) * car.exhaust_tq_mod
		var x_mod = (float(car.engine_rpm - 2000) / float(car.max_engine_rpm))*125 -28
		var hp_y_mod = (float(hp) / float(max_tq)) * 60 -20
		var tq_y_mod = (float(tq) / float(max_tq)) * 60 -20
		if tq > max_tq *0.01 and car.engine_rpm >= 2000:
			hp_line.add_point(Vector2(get_parent().global_position.x + x_mod, get_parent().global_position.y - hp_y_mod))
			tq_line.add_point(Vector2(get_parent().global_position.x + x_mod, get_parent().global_position.y - tq_y_mod))
		if tq != 0 and hp != 0:
			tq_text.text = "Torque: " + str(int(tq))+"Nm"
			hp_text.text = "Power: " + str(int(hp))+"Hp"
			boost_text.text = "Boost: " + str("%0.2f" % car.engine.boost)+"Bar"
			rpm_text.text = "Rpm: "+str(int(car.engine_rpm)+10)+"Rpm"
		#Knock
		if car.engine.knock() != 0:
			knock_text.show()
	if car.shift_cooldown == true:
			temp_rpm = 0


var temp_hp = 0.0
var temp_tq = 0.0
func display_peak_figures():
	if car.gear == 3:
		if hp > temp_hp:
			temp_hp = hp
			max_hp_text.text = "Peak Hp: " + str(int(temp_hp))+"Hp" + " @" + str(int(car.engine_rpm)) + "RPM"
		if tq > temp_tq:
			temp_tq = tq
			max_tq_text.text = "Peak Nm: " + str(int(temp_tq))+"Nm" + " @" + str(int(car.engine_rpm)) + "RPM"


func spin_rollers():
	var speed = car.speed_kmh * 0.1
	if speed > 0.1 and car.engine.is_running:
		if car.drive_train_type == 0 or car.drive_train_type == 2: #RWD AWD
			rear_wheels.play("Spin")
			rear_wheels.speed_scale = speed
		if car.drive_train_type == 1 or car.drive_train_type == 2: #FWD AWD
			front_wheels.play("Spin")
			front_wheels.speed_scale = speed
	else:
		rear_wheels.play("RESET")
		front_wheels.play("RESET")
