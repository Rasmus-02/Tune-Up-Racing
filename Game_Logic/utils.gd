extends Node
signal freeing_orphans
var blocked = false

func free_orphaned_nodes():
	if blocked == false:
		emit_signal("freeing_orphans")

func _ready():
	#Set script to "not pauseable"
	process_mode = Node.PROCESS_MODE_ALWAYS
