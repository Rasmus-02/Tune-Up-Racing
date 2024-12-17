shader_type canvas_item;

uniform float grain_strength : hint_range(0.0, 1.0) = 0.1; // Strength of the grain
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    vec2 uv = SCREEN_UV; // Normalized screen UV coordinates

    // Generate static grain noise
    float noise = fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);

    // Invert the noise to make it black
    noise = -(noise * grain_strength);

    // Sample the background texture
    vec4 bg_color = texture(screen_texture, uv);

    // Subtract the noise from the background color
    vec3 final_color = bg_color.rgb + vec3(noise);

    // Clamp color values to ensure they stay within the valid range
    final_color = clamp(final_color, 0.0, 1.0);

    COLOR = vec4(final_color, bg_color.a); // Preserve alpha channel
}