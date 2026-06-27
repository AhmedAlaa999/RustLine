extends TextureRect

var timer = 0.0
func _process(delta):
	timer += delta
	if timer > 0.5:
		visible = !visible
		timer = 0.0
