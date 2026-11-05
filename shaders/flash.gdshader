shader_type canvas_item;

uniform float start_time = 0.0;

// TODO I just made this shader quickly.
// This is definitely not Deltarune-accurate.
// I will need to look into how Deltarune does this.

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	// float flash = 0.5 + 0.5 * sin(4.0 * TIME);
	float time = TIME - start_time;
	float flash = 2.0 * abs(mod(time / 2.0, 1.0) - 0.5);
	COLOR.rgb = vec3(mix(COLOR.rgb, vec3(1.0), flash));
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
