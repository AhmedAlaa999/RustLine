extends Area2D
#The fire like it is a a trap that damgae the player
func _on_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(1)
