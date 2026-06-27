extends Area2D
#This is the coin the shows beside the counter
@export var float_height := 5.0
@export var float_speed := 2.0
@export var rotation_speed := 180.0

var start_y := 0.0
var time := 0.0

func _ready():
	start_y = position.y
func _process(delta):
	time += delta
	position.y = start_y + sin(time * float_speed) * float_height
	rotation_degrees += rotation_speed * delta
