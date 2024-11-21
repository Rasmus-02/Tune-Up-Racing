extends TextureButton

var requirement : String

func paint(paint_name, paint_color, requirement_text, unlocked):
	#Set Name
	$"Color Name".text = paint_name
	
	#Set Color
	var new_material = ShaderMaterial.new()
	var shader = load("res://Shaders/Test/ColorSelector.gdshader")
	new_material.shader = shader
	self.material = new_material
	self.material.set_shader_parameter("import_new_color", paint_color)
	
	#Turn of hover light
	$Rarity.modulate = Color(0.05490196123719, 0.2392156869173, 0.07058823853731)
	
	#Update Requirement text
	requirement = requirement_text
	
	#Unlock or lock
	if unlocked:
		$Background.frame = 1
	else:
		$Background.frame = 0


func _on_mouse_entered():
	_on_focus_entered()
func _on_focus_entered():
	$Rarity.modulate = Color(0, 0.93797540664673, 0)
	get_parent().update_requirement(requirement)



func _on_mouse_exited():
	_on_focus_exited()
func _on_focus_exited():
	$Rarity.modulate = Color(0.05490196123719, 0.2392156869173, 0.07058823853731)



