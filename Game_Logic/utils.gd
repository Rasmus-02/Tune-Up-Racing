extends Node
signal freeing_orphans
signal changing_scene
var blocked = false

func free_orphaned_nodes():
	if blocked == false:
		emit_signal("freeing_orphans")

func change_scene():
	emit_signal("changing_scene")

func _ready():
	#Set script to "not pauseable"
	process_mode = Node.PROCESS_MODE_ALWAYS
