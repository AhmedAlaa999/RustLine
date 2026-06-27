extends CanvasLayer

@onready var label = $Label
@onready var victory_sound = $VictorySound
@onready var music = $"../BackgroundMusic"

func _ready():
	visible = false
	label.visible = false

	add_to_group("winner_screen")

func player_won():
	visible = true
	label.visible = true

	if music:
		music.stop()

	if victory_sound.stream:
		victory_sound.play()
