extends CanvasLayer

@onready var timer_label = $TimerLabel
@onready var game_timer = $GameTimer

func _ready():
	game_timer.wait_time = GameManager.time_left
	game_timer.one_shot = true
	game_timer.autostart = false
	game_timer.start()

func _process(delta):
	GameManager.time_left = game_timer.time_left
	timer_label.text = "Time: " + str(ceil(game_timer.time_left))

func _on_game_timer_timeout():
	if GameManager.total_coins < GameManager.WIN_COINS:
		print("Time is up! Player lost.")

		GameManager.health = 0

		var player = get_tree().get_first_node_in_group("player")
		if player:
			player.take_damage(0)
