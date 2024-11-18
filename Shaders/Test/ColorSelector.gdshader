shader_type canvas_item;

uniform vec4 import_new_color; // Use a color picker in the editor

void fragment() {
    vec4 color = texture(TEXTURE, UV);

    // Original colors to match
    vec4 light_origin = vec4(0.0, 1.0, 0.0, 1.0); // Light
    vec4 normal_origin = vec4(1.0, 1.0, 0.0, 1.0); // Normal
    vec4 normal_dark_origin = vec4(1.0, 0.0, 0.0, 1.0); // Normal Dark
    vec4 dark_origin = vec4(1.0, 0.0, 1.0, 1.0); // Dark
    vec4 darker_dark_origin = vec4(0.0, 1.0, 1.0, 1.0); // Darker Dark
    vec4 darkest_origin = vec4(0.0, 0.0, 1.0, 1.0); // Darkest

    // Replacement colors (calculated shades)
    vec4 light_color = vec4(import_new_color.rgb * 1.15, 1.0);
    vec4 normal_color = vec4(import_new_color.rgb * 1.0, 1.0);
    vec4 normal_dark_color = vec4(import_new_color.rgb * 0.92, 1.0);
    vec4 dark_color = vec4(import_new_color.rgb * 0.7, 1.0);
    vec4 darker_dark_color = vec4(import_new_color.rgb * 0.4, 1.0);
    vec4 darkest_color = vec4(import_new_color.rgb * 0.2, 1.0);

    // Match and replace colors
    if (color == light_origin) {
        color = light_color;
    } else if (color == normal_origin) {
        color = normal_color;
    } else if (color == normal_dark_origin) {
        color = normal_dark_color;
    } else if (color == dark_origin) {
        color = dark_color;
    } else if (color == darker_dark_origin) {
        color = darker_dark_color;
    } else if (color == darkest_origin) {
        color = darkest_color;
    }

    // Output the final color
    COLOR = color;
}