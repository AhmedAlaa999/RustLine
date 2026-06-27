extends TextureRect
#for background animation
var speed = 20
func _process(delta):
	position.x -= speed * delta
	if position.x <= -texture.get_width():
		position.x = 0
