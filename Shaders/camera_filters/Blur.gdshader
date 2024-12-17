shader_type canvas_item;

uniform float blur_amount : hint_range(0.0, 10.0) = 2.0;
uniform int blur_samples : hint_range(1, 16) = 8;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap; // The fix!

void fragment() {
    ivec2 texture_size = textureSize(SCREEN_TEXTURE, 0);
    vec2 tex_size = vec2(texture_size);
    vec2 pixel_size = vec2(1.0) / tex_size;
    vec2 uv = SCREEN_UV;

    vec4 blurred_color = vec4(0.0);

    for (int i = 0; i < blur_samples; i++) {
        float angle = float(i) * (6.28318530718 / float(blur_samples));
        vec2 offset = vec2(cos(angle), sin(angle)) * blur_amount * pixel_size;
        blurred_color += texture(SCREEN_TEXTURE, uv + offset);
    }

    blurred_color /= float(blur_samples);

    COLOR = blurred_color;
}