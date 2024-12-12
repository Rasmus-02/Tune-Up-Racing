extends Node
signal freeing_orphans

func free_orphaned_nodes():
	print("Signal freeing_orphans emitted") 
	emit_signal("freeing_orphans")
