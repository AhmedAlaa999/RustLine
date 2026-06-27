extends Area2D

func _on_body_entered(body):
	if body.name == "Main Character":
		get_tree().change_scene_to_file("res://main_map.tscn")
