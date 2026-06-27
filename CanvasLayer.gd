extends CanvasLayer
#for the teleport to work in everyteleportation system
func fade_to_scene(target_scene):
	get_tree().change_scene_to_file(target_scene)
