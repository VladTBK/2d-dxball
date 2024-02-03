extends Node


func _ready():
	pass


func _process(delta):
	# check if any balls left
	var ball_count = get_tree().get_nodes_in_group("ball")
	if not ball_count:
		get_tree().change_scene_to_file("res://UI/ui.tscn")
		return
