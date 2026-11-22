extends CanvasLayer

# Video Settings
@onready var FullscreenButton = $FullscreenButton
@onready var CRTFilterButton = $CRTFilterButton

# Audio Settings
@onready var MusicSlider = $MusicSlider
@onready var SFXSlider = $SFXSlider

var video_settings
var audio_settings

var Music
var SFX

func _ready():
	layer = 1028
	
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	video_settings = SettingsFile.load_video_settings()
	audio_settings = SettingsFile.load_audio_settings()
	
	Music = AudioServer.get_bus_index("Music")
	SFX = AudioServer.get_bus_index("SFX")
	
	# Set Options
	MusicSlider.value = audio_settings.music
	SFXSlider.value = audio_settings.sfx
	
	FullscreenButton.button_pressed = video_settings.fullscreen
	CRTFilterButton.button_pressed = video_settings.crt_filter

func _input(event: InputEvent):
	if event.is_action_pressed("pause"):
		_back_button_pressed()

func _back_button_pressed():
	AudioManager.play_sfx(Audio.click)
	SceneHandler.hide_options()

func _audio_changed(value: float, bus):
	var newVolume = linear_to_db(value)
	AudioServer.set_bus_volume_db(bus, newVolume)

func _music_volume_changed(value: float) -> void:
	_audio_changed(value, Music)
	
	SettingsFile.save_audio_setting("music", value)

func _sfx_volume_changed(value: float) -> void:
	_audio_changed(value, SFX)
	
	SettingsFile.save_audio_setting("sfx", value)

func _fullscreen_button_toggled(toggled_on: bool):
	if (toggled_on == true):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		if (DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_MAXIMIZED):
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	SettingsFile.save_video_setting("fullscreen", toggled_on)

func _crt_filter_toggled(toggled_on: bool):
	CrtFilter.toggle_crt_filter(toggled_on)
	SettingsFile.save_video_setting("crt_filter", toggled_on)
