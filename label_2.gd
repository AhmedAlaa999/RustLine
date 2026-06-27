extends Label

@export var first_scene: String = "res://main_menu.tscn"

var timer := 0.0

func _process(delta):
	timer += delta
	if timer >= 0.5:
		visible = !visible
		timer = 0.0
	if Input.is_action_just_pressed("Restart"):
		GameManager.reset_game()
		get_tree().change_scene_to_file(first_scene)
