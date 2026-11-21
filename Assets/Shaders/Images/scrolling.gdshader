shader_type canvas_item;

group_uniforms values;
uniform float speed = 0.1;

group_uniforms scroll_enabled;
uniform bool scrolling_horizontally = true;
uniform bool scrolling_vertically = false;

group_uniforms scroll_direction;
uniform bool scrolling_left = true;
uniform bool scrolling_up = true;

void vertex()
{
	if (scrolling_horizontally)
	{
		if (scrolling_left) UV.x += TIME * speed;
		else UV.x += TIME * -speed;
	}
	
	if (scrolling_vertically)
	{
		if (scrolling_up) UV.y -= TIME * speed;
		else UV.y -= TIME * -speed;
	}
}