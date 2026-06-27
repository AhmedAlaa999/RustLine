extends TileMapLayer
#for background animation 
var speed = 10
func _process(delta):
	position.x -= speed * delta
