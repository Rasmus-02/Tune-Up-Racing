extends Sprite2D

@export var import_new_color : Color
var origin = Color(0.0, 0.0, 0.0)
var loaded = false

func change_color():
	var new_color = Color(1.0, 0.0, 0.0)
	var image: Image = self.texture.get_image()
	for i in range(6):
		if i == 0: #Light
			origin = Color(0.0, 1.0, 0.0)
			new_color = import_new_color * 1.15
			new_color.a = 1
		if i == 1: #Normal
			origin = Color(1.0, 1.0, 0.0)
			new_color = import_new_color * 1
			new_color.a = 1
		if i == 2: #Normal Dark
			origin = Color(1.0, 0.0, 0.0)
			new_color = import_new_color *0.92
			new_color.a = 1
		if i == 3: #Dark (engine bay top)
			origin = Color(1.0, 0.0, 1.0)
			new_color = import_new_color * 0.7
			new_color.a = 1
		if i == 4: #Darker Dark (engine bay bottom)
			origin = Color(0.0, 1.0, 1.0)
			new_color = import_new_color * 0.40
			new_color.a = 1
		if i == 5: #Darkest (lights)
			origin = Color(0.0, 0.0, 1.0)
			new_color = import_new_color * 0.20
			new_color.a = 1
		
		for y in image.get_height():
			for x in image.get_width():
				if image.get_pixel(x, y) == origin:
					image.set_pixel(x, y, new_color)
		
		var new_texture = ImageTexture.create_from_image(image)
		self.texture.set_diffuse_texture(new_texture) 
		i += 1
