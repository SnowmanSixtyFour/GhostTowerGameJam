extends Control

@onready var transition_rect = $Transition

var transition_amount = 0.005

func _ready():
	transition_rect.show()

func _process(delta: float):
	# Transition when starting game
	if transition_rect.color.a > 0:
		transition_rect.color.a -= transition_amount
	elif transition_rect.color.a < 0:
		transition_rect.color.a = 0

func _input(event: InputEvent):
	if Input.is_action_just_pressed("start"):
		SceneHandler.go_to_scene(SceneHandler.main_menu)
