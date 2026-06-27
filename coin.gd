extends Area2D
#The Coin thing BRB
var collected = false
func _ready():
	if name in GameManager.collected_coins:
		queue_free()

func _on_body_entered(body):
	if body.name == "Main Character" and !collected:
		collected = true
		
		
		if name not in GameManager.collected_coins:
			GameManager.collected_coins.append(name)

		GameManager.add_coin()
		
		body.coins = GameManager.total_coins
		
		var counter = get_tree().get_first_node_in_group("coin_counter")
		if counter:
			counter.text = str(GameManager.total_coins)
		
		$CollisionShape2D.disabled = true
		$AudioStreamPlayer.play()
		$AnimatedSprite2D.play("A12")
		
		await get_tree().create_timer(0.5).timeout
		queue_free()
