extends Control

@onready var options_window = $OptionsWindow
@onready var credits_window = $CreditsWindow
@onready var quit_game_window = $QuitGameWindow

@onready var press_start_label = $PressStartLabel

var previous_options_position: Vector2i

var move_credits_opposite = true
var move_credits = false
var screen_width = 640

var last_focused_window
var warning = false
var quit_game_window_position

func _ready():
	# Hide buttons
	options_window.hide()
	credits_window.hide()
	
	previous_options_position = options_window.position
	
	quit_game_window.hide()
	quit_game_window_position = quit_game_window.position
	
	# Connect button input
	options_window.window_input.connect(_input)
	credits_window.window_input.connect(_input)
	quit_game_window.window_input.connect(_input)
	
	options_window.focus_entered.connect(_on_window_focused.bind(options_window))
	credits_window.focus_entered.connect(_on_window_focused.bind(credits_window))

func _process(delta: float):
	if options_window.position != previous_options_position:
		move_credits = true
	
	# Move credits window before seen
	if move_credits:
		if move_credits_opposite:
			credits_window.position.x = screen_width - options_window.position.x - credits_window.size.x
	
	# Keep focus on quit game window
	if warning:
		quit_game_window.grab_focus()
	
	# Prevent quit game window from moving
	quit_game_window.position = quit_game_window_position

func _input(event: InputEvent):
	if Input.is_action_just_pressed("start"):
		show_options()
	
	if Input.is_action_just_pressed("exit"):
		warn_about_closing()

func start_game():
	AudioManager.play_sfx(Audio.click)

func show_options():
	# Show window
	options_window.show()
	options_window.grab_focus()
	
	# Hide other objects
	press_start_label.stop_flashing()

func show_credits():
	move_credits_opposite = false
	
	AudioManager.play_sfx(Audio.click)
	
	credits_window.show()
	credits_window.grab_focus()

func hide_credits():
	AudioManager.play_sfx(Audio.click)
	
	credits_window.hide()
	
	# Refocus
	options_window.grab_focus()

func close_game_via_button():
	AudioManager.play_sfx(Audio.click)
	warn_about_closing()

func _on_window_focused(window: Window):
	last_focused_window = window

func warn_about_closing():
	options_window.gui_disable_input = true
	credits_window.gui_disable_input = true
	
	quit_game_window.show()
	quit_game_window.grab_focus()
	
	warning = true

func exit_warn():
	AudioManager.play_sfx(Audio.click)
	
	options_window.gui_disable_input = false
	credits_window.gui_disable_input = false
	
	quit_game_window.hide()
	last_focused_window.grab_focus()
	
	warning = false

func close_game():
	get_tree().quit()
