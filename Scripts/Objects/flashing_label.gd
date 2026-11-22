# @tool
extends Label

var flashing = true

func _ready():
	flash_text()

func flash_text():
	while flashing:
		visible = not visible
		await get_tree().create_timer(0.55).timeout

func stop_flashing():
	flashing = false
	hide()
