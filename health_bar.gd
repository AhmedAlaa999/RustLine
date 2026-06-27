extends CanvasLayer

var current_health = -1

func _ready():
	update_health(GameManager.health)

func update_health(health):
	if health == current_health:
		return
	current_health = health
	var hearts = get_node_or_null("AnimatedSprite2D")
	if hearts == null:
		return

	match health:
		4:
			hearts.play("Full Heart")
		3:
			hearts.play("3 Heart")
		2:
			hearts.play("2 Heart")
		1:
			hearts.play("1 Heart")
		0:
			hearts.play("0")
