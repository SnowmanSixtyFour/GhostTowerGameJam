extends Window

var screen_bottom = 5
var screen_top = 25

func _process(delta: float):
	var parent_window = get_parent()
	
	var max_pos = Vector2i(parent_window.size) - size
	max_pos.x = maxi(max_pos.x, 0)
	max_pos.y = maxi(max_pos.y, 0)
	
	var min_pos = Vector2i(screen_bottom, screen_top)
	
	position = position.clamp(min_pos, max_pos)
