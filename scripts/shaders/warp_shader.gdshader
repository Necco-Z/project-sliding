shader_type spatial;
render_mode world_vertex_coords;

global uniform float curve_y;
global uniform float curve_z;
uniform sampler2D texture_file: source_color;
uniform vec3 albedo: source_color;
uniform sampler2D normal: hint_normal;
uniform sampler2D metal_rough;
uniform float metallic: hint_range(0.0, 1.0, 0.1);
uniform float roughness: hint_range(0.0, 1.0, 0.1);

void vertex() {
	vec3 camera_offset = VERTEX - CAMERA_POSITION_WORLD;
	vec3 warp_factor = vec3(0.0, curve_y, curve_z) * pow(camera_offset.x, 2.0) * 0.001;
	VERTEX += warp_factor;
}

void fragment() {
	NORMAL_MAP = texture(normal, UV).xyz;
	if (textureQueryLevels(texture_file) == 1) {
		ALBEDO = albedo;
	} else {
		ALBEDO = texture(texture_file, UV).xyz;
	}
	if (textureQueryLevels(metal_rough) == 1) {
		ROUGHNESS = roughness;
		METALLIC = metallic;
	} else {
		ROUGHNESS = texture(metal_rough, UV).g;
		METALLIC = texture(metal_rough, UV).b;
	}
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
