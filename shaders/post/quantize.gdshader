shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

uniform int amount = 1;

void fragment()
{
	vec2 resolution = (1./SCREEN_PIXEL_SIZE);
	vec2 grid_uv = (round(UV * resolution / float(amount)) / resolution) * float(amount);
	
	COLOR = texture(SCREEN_TEXTURE, grid_uv);
}