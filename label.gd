extends Label

var messages = [
	"Welcome My Friend!",
	"I have Made this game because",
	"I Want to know Nothing Nothing!!",
	"So How to Play",
	"Just Press ASDW TO MOVE",
	"So You Want To Jump Press Space",
	"To Win in This is game:",
	"Easy, Just Collect Princess Coins",
	"Before she dies, for sure,",
	"and before the time runs out",
	"Avoid the Traps",
	"So That's All",
	"Don't press Enter, or it will keep looping",
	"Hey! I said don't press Enter",
	"Enter has entered the chat",
	"Bye"
]

var index = 0

func _ready():
	text = messages[0]
	modulate = Color("#D9C2FF")

func _input(event):
	if event.is_action_pressed("ui_accept"):

		var tween = create_tween()

		# Fade out
		tween.tween_property(self, "modulate:a", 0.0, 0.15)

		# Change text halfway through
		tween.tween_callback(func():
			index = (index + 1) % messages.size()
			text = messages[index]
		)

		# Fade back in
		tween.tween_property(self, "modulate:a", 1.0, 0.15)
