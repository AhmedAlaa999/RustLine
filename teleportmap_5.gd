extends Area2D

func _on_body_entered(body):
	if body.name == "Main Character":
		$FadeLayer.fade_to_scene("res://Map5.tscn")
