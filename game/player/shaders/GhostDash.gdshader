shader_type canvas_item;

uniform bool whiten = false;
uniform float mix_weight = 1.0;
uniform float mix_alpha = 0.5;

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	if(whiten) {
		vec3 white = vec3(0.78, 0.78, 0.78);
		vec3 whiteed_texture_rgb = mix(texture_color.rgb, white, mix_weight);
		COLOR = vec4(whiteed_texture_rgb, texture_color.a * mix_alpha);
	}
	else {
		COLOR = texture_color;
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
