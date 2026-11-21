extends Node

@onready var layer = $CRTFilterLayer

var video_settings

func _ready() -> void:
	layer.layer = 1030
	
	video_settings = SettingsFile.load_video_settings()
	
	# Auto show / hide filter on startup
	toggle_crt_filter(video_settings.crt_filter)

func toggle_crt_filter(value: bool):
	if (value == true):
		layer.show()
	else:
		layer.hide()
