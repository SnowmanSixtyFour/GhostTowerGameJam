extends CanvasLayer

@onready var PauseMenuWindow = $Screen/PauseMenuWindow

@onready var HotbarWindow = $Screen/HotbarWindow
@onready var Score = $Screen/Score

var prevent_pause = false
var hud_hidden = false

func _ready():
	# Hide Windows
	PauseMenuWindow.hide()
	
	# Make sure HUD cannot override input
	PauseMenuWindow.window_input.connect(_input)
	HotbarWindow.window_input.connect(_input)
	
	# Focus
	HotbarWindow.grab_focus()

func _process(delta: float):
	pass

func _input(event: InputEvent):
	# Pause
	if not prevent_pause:
		if Input.is_action_just_pressed("pause"):
			toggle_pause()
		
	# Hotbar Visibility
	if Input.is_action_just_pressed("toggle_hotbar"):
		var new_hotbar_visibility = !HotbarWindow.visible
		toggle_hotbar(new_hotbar_visibility)

func close_hotbar_button():
	AudioManager.play_sfx(Sfx.click)
	toggle_hotbar(false)

func toggle_hotbar(show: bool):
	if show:
		HotbarWindow.show()
		Score.show()
	else:
		HotbarWindow.hide()
		Score.hide()
	
	# Don't stay focused on HUD elements
	if get_tree().paused: PauseMenuWindow.grab_focus()

func toggle_pause():
	var new_pause_state = !get_tree().paused
	get_tree().paused = new_pause_state
	
	if new_pause_state: PauseMenuWindow.show()
	else: PauseMenuWindow.hide()

func unpause_game():
	get_tree().paused = false
	PauseMenuWindow.hide()

func press_resume_button():
	AudioManager.play_sfx(Sfx.click)
	unpause_game()

func press_return_button():
	AudioManager.play_sfx(Sfx.click)
	
	prevent_pause = true
	unpause_game()
	
	SceneHandler.go_to_scene(SceneHandler.main_menu)
