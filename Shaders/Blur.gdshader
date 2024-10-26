shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform float gridSize = 32.0; // Size of the checkered squares
uniform float blurAmount1 : hint_range(0.0, 5.0); // Blur amount for the first type of square
uniform float blurAmount2 : hint_range(0.0, 5.0); // Blur amount for the second type of square
uniform float whiteTintIntensity1 : hint_range(0.0, 1.0) = 0.5; // White tint intensity for the first type of square
uniform float whiteTintIntensity2 : hint_range(0.0, 1.0) = 0.5; // White tint intensity for the second type of square

void fragment() {
    // Get normalized UV coordinates (range from 0 to 1)
    vec2 uv = SCREEN_UV;

    // Get the aspect ratio of the screen
    float aspectRatio = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;

    // Adjust the y-coordinate by the inverse of the aspect ratio to maintain square grid cells
    vec2 gridUV = vec2(uv.x, uv.y * aspectRatio) * gridSize;

    // Floor the UV coordinates to get integer grid indices
    vec2 gridPos = floor(gridUV);

    // Create a checkered pattern using mod
    float checker = mod(gridPos.x + gridPos.y, 2.0);

    // Select blur amount based on the checkered pattern
    float blurAmount = mix(blurAmount1, blurAmount2, checker);

    // Apply blur to the texture using the chosen amount
    vec4 color = textureLod(screen_texture, SCREEN_UV, blurAmount);
    
    // Apply white tint based on checker pattern
    if (checker == 1.0) {
        // Interpolate between the current color and white based on the respective tint intensity
        color.rgb = mix(color.rgb, vec3(1.0, 1.0, 1.0), whiteTintIntensity2);
    } else {
        // Interpolate for the other type of square
        color.rgb = mix(color.rgb, vec3(1.0, 1.0, 1.0), whiteTintIntensity1);
    }

    // Set the final color
    COLOR = color;
}

void light() {
    // Handle lighting if necessary (not used in this case)
}