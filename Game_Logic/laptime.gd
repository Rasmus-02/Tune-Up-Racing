extends Node

var ms : float
var paused = true
var disqualified = false
var record_time : float

func _process(delta):
	if paused == false:
		ms = ms + delta

func reset_timer():
	ms = 0.0

func set_record():
	if (ms < record_time or record_time == 0) and ms != 0.0 and disqualified == false:
		record_time = ms
	reset_timer()

func get_record():
	if record_time != null and record_time != 0:
		return time_to_minutes_secs_mili(record_time, "Record")
	else:
		return "-''-''-"

func disqualify():
	disqualified = true
	reset_timer()
	paused = true

func get_current():
	return time_to_minutes_secs_mili(ms, "Current")

func time_to_minutes_secs_mili(time : float, type):
	var mins = int(time) / 60
	time -= mins * 60
	var secs = int(time) 
	var mili = int((time - int(time)) * 100)
	if disqualified == false:
		return str(mins) + ":" + str(secs) + ":" + str(mili)
	elif type == "Current":
		return "DNF"
