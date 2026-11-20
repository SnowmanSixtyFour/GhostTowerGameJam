extends Control

func _ready():
	pass

func _process(delta: float):
	pass

func _input(event: InputEvent):
	if Input.is_action_pressed("ui_accept"):
		go_to_main_menu()

func go_to_main_menu():
	SceneHandler.go_to_scene(SceneHandler.main_menu)
