extends Node2D


var main = null

func _ready():
	#Set script to "not pauseable"
	process_mode = Node.PROCESS_MODE_ALWAYS
	main = get_tree().get_root().get_node("Main")
	$AnimationPlayer.play("start")
	$Sprite.play("start")

func _on_animation_player_animation_finished(_anim_name):
	main.change_scene("garage")
