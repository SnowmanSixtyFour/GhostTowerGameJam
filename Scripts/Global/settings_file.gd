extends Node

var config = ConfigFile.new()
const OPTIONS_FILE_PATH = "user://game_jam_options.ini"

func _ready() -> void:
	## Create options.ini
	
	if (!FileAccess.file_exists(OPTIONS_FILE_PATH)):
		config.set_value("video", "fullscreen", true)
		config.set_value("video", "crt_filter", true)
		
		config.set_value("audio", "music", 1.0)
		config.set_value("audio", "sfx", 1.0)
		
		config.save(OPTIONS_FILE_PATH)
	else:
		config.load(OPTIONS_FILE_PATH)
	
	## Load options.ini
	
	var video_settings = load_video_settings()
	
	if video_settings.fullscreen == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func save_video_setting(key: String, value):
	config.set_value("video", key, value)
	config.save(OPTIONS_FILE_PATH)

func load_video_settings():
	var video_settings = {}
	for key in config.get_section_keys("video"):
		video_settings[key] = config.get_value("video", key)
	
	return video_settings

func save_audio_setting(key: String, value):
	config.set_value("audio", key, value)
	config.save(OPTIONS_FILE_PATH)

func load_audio_settings():
	var audio_settings = {}
	for key in config.get_section_keys("audio"):
		audio_settings[key] = config.get_value("audio", key)
	
	return audio_settings
