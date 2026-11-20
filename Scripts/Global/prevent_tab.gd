extends Node

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_TAB:
		get_viewport().set_input_as_handled()
