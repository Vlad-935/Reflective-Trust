shader_type canvas_item;
uniform bool active = false;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	if (active){
		float average = (color.r + color.g + color.b) / 3.0;
		COLOR = vec4(average, average, average, color.a);
	} else {
		COLOR = color;
	}
}
