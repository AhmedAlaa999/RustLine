extends Control

var starting = false
func _input(event):
	if starting:
		return

	if event.is_action_pressed("ui_accept"):
		starting = true
		$PressEnter/Hi.play()
		var tween = create_tween()
		tween.tween_property($ColorRect, "modulate:a", 1.0, 0.5)
		await tween.finished
		get_tree().change_scene_to_file("res://main_map.tscn")
