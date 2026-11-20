extends Control

@onready var options_window = $OptionsWindow
@onready var credits_window = $CreditsWindow

func _ready():
	# Set Window Focus
	options_window.grab_focus()
	credits_window.hide()

func _process(delta: float):
	pass

func show_credits():
	credits_window.show()
	credits_window.grab_focus()

func hide_credits():
	credits_window.hide()
	
	# Refocus
	options_window.grab_focus()

func close_game():
	get_tree().quit()
