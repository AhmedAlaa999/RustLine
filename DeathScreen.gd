extends CanvasLayer
#The death screen Btw
@onready var lose = $Label
@onready var death_sound = $DeathSound
@onready var music = $"../BackgroundMusic"

func _ready():
	visible = false
	lose.visible = false
	add_to_group("death_screen")

func player_died():
	visible = true
	lose.visible = true

	music.stop()          
	death_sound.play()    
