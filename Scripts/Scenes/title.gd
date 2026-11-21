extends Control

@onready var options_window = $OptionsWindow
@onready var credits_window = $CreditsWindow

@onready var press_start_label = $PressStartLabel

func _ready():
	# Set title
	options_window.hide()
	credits_window.hide()

func _process(delta: float):
	pass

func _input(event: InputEvent):
	if Input.is_action_pressed("ui_accept"):
		show_options()

func show_options():
	# Show window
	options_window.show()
	options_window.grab_focus()
	
	# Hide other objects
	press_start_label.stop_flashing()

func show_credits():
	AudioManager.play_sfx(Audio.click)
	
	credits_window.show()
	credits_window.grab_focus()

func hide_credits():
	AudioManager.play_sfx(Audio.click)
	
	credits_window.hide()
	
	# Refocus
	options_window.grab_focus()

func close_game():
	get_tree().quit()
