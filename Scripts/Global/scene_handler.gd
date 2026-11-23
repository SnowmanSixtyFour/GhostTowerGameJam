extends Node

var main_menu = preload("res://Scenes/Game/main_menu.tscn")
var ghost_tower = preload("res://Scenes/Game/ghost_tower.tscn")
var options = preload("res://Scenes/Game/options.tscn")
var slot_machine = preload("res://Scenes/Game/slot_machine.tscn")

var previous_scene = main_menu

var options_instance = null
var opened_options = false
var is_options_visible = false

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

func show_options():
	opened_options = true
	
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	
	is_options_visible = true
	opened_options = false
	
	# Create Options
	if options_instance == null:
		options_instance = options.instantiate()
		get_tree().root.add_child(options_instance)
	
	# Open Options
	options_instance.show()

func hide_options():
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	
	is_options_visible = false
	options_instance.queue_free()

func print_error():
	print("Error! No valid scene was provided!")
