extends Node2D

func _ready():
	var tween = create_tween()
	$ColorRect.modulate.a = 1.0
	tween.tween_property($ColorRect, "modulate:a", 0.0, 1.0)
