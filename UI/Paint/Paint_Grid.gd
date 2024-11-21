extends GridContainer
var paint_card = preload("res://UI/Paint/Paint Card.tscn")

# Called when the node enters the scene tree for the first time.
func populate_grid():
	#Clear out List
	for i in get_child_count():
			get_child(i).queue_free()
	
	#Update List
	for color in Colors.list:
		var instance = paint_card.instantiate()
		print("ADD")
		instance.paint(color[1], color[0], color[2], 1)
		add_child(instance)

func update_requirement(requirement):
	$"../../Requirement".text = requirement
