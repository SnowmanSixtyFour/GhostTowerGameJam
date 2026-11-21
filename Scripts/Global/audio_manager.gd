extends Node

@onready var Music: AudioStreamPlayer = $Music
@onready var SFX: AudioStreamPlayer = $SFX

var audio_settings

func _ready() -> void:
	Music.bus = "Music"
	SFX.bus = "SFX"
	
	audio_settings = SettingsFile.load_audio_settings()
	
	apply_audio_volume()

func apply_audio_volume():
	set_bus_volume("Music", audio_settings.music)
	set_bus_volume("SFX", audio_settings.sfx)

func set_bus_volume(bus_name: String, volume: float):
	var bus_index = AudioServer.get_bus_index(bus_name)
	
	AudioServer.set_bus_volume_linear(bus_index, clampf(volume, 0.0, 1.0))

func play_music(path):
	if not (Music.playing and Music.stream.resource_path == path):
		Music.stream = load(path) as AudioStream
		
		Music.play()

func stop_music():
	Music.stop()

func play_sfx(path):
	if not (SFX.playing and SFX.stream.resource_path == path):
		SFX.stream = load(path) as AudioStream
		SFX.play()

func stop_sfx():
	SFX.stop()
