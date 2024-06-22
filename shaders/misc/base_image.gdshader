shader_type spatial;

uniform sampler2D albedo_texture;

void fragment() {
	vec4 processed = texture(albedo_texture, UV);
	ALBEDO = processed.rgb;
	ALPHA = processed.a;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
