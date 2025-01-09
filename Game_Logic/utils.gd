extends Node
signal freeing_orphans

func free_orphaned_nodes():
	emit_signal("freeing_orphans")

func _ready():
	#Set script to "not pauseable"
	process_mode = Node.PROCESS_MODE_ALWAYS
