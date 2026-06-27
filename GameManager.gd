extends Node
# This script is global and stays across all scenes
var collected_coins = []
var total_coins = 0
const WIN_COINS = 15

var health = 4
var max_health = 4
var time_left = 60.0

func _input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func add_coin():
	total_coins += 1
	if total_coins >= WIN_COINS:
		var win_screen = get_tree().get_first_node_in_group("winner_screen")
		if win_screen:
			win_screen.player_won()

func reset_game():
	health = max_health
	total_coins = 0
	collected_coins.clear()
	time_left = 60.0
