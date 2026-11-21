extends Node

var title = preload("res://Scenes/GUI/title.tscn")

var previous_scene = title

func go_to_scene(scene_name):
	set_previous_scene()
	
	if scene_name != null:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		get_tree().change_scene_to_packed(scene_name)
	else:
		print_error()

func cut_to_scene(scene_name):
	set_previous_scene()
	
	if scene_name != null:
		get_tree().change_scene_to_packed(scene_name)
	else:
		print_error()

func set_previous_scene():
	previous_scene = load(get_tree().current_scene.scene_file_path)

func current_scene_is(scene_name):
	var current_scene = load(get_tree().current_scene.scene_file_path)
	
	if current_scene == scene_name:
		return true
	else:
		return false

func print_error():
	print("Error! No valid scene was provided!")
