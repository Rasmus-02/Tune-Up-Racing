extends Node2D

var increase = true
var durability = 0.001
var new_color = Colors.list[12][0]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if durability == 1:
		increase = false
	elif durability == 0:
		increase = true
		var max_rng = Colors.list.size() - 1 #-1 because start at index 0
		var rng = randi_range(0, max_rng)
		new_color = Colors.list[rng][0]
	
	if increase == true:
		durability += 0.001
	else:
		durability -= 0.001
	
	$Damage.value = durability
	
	durability = clamp(durability, 0, 1)
	$Car.material.set_shader_parameter("sensitivity", durability)
	$Hood.material.set_shader_parameter("sensitivity", durability)
	$Fenders.material.set_shader_parameter("sensitivity", durability)
	
	
	$Car.material.set_shader_parameter("import_new_color", new_color)
	$Hood.material.set_shader_parameter("import_new_color", new_color)
	$Fenders.material.set_shader_parameter("import_new_color", new_color)
