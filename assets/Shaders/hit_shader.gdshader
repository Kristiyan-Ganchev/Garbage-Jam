shader_type canvas_item;

uniform bool active = false;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
    vec4 tint = texture(TEXTURE, UV);
    if (active == true) {
        tint.rgb = vec3(1.0, 1.0, 1.0);
    }
    COLOR = tint;
}
