extends Label

@onready var timer = $"../GameTimer"

func _process(delta):
	text = "Timer: " + str(int(timer.time_left))
