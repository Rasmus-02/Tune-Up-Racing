shader_type canvas_item;
render_mode blend_mix;

// Wind settings.
uniform float speed = 1.0;
uniform float minStrength : hint_range(0.0, 1.0) = 0.05;
uniform float maxStrength : hint_range(0.0, 1.0) = 0.01;
uniform float strengthScale = 100.0;
uniform float interval = 3.5;
uniform float detail = 1.0;
uniform float distortion : hint_range(0.0, 1.0);
uniform float heightOffset : hint_range(0.0, 1.0);

// With the offset value, you can if you want different moves for each asset. Just put a random value (1, 2, 3) in the editor. Don't forget to mark the material as unique if you use this
uniform float offset = 0; 


float getWind(vec2 vertex, vec2 uv, float time){
    float diff = pow(maxStrength - minStrength, 2.0);
    float strength = clamp(minStrength + diff + sin(time / interval) * diff, minStrength, maxStrength) * strengthScale;
    float wind = (sin(time) + cos(time * detail)) * strength * max(0.0, (1.0-uv.y) - heightOffset);
    
    return wind; 
}

void vertex() {
    vec4 pos = MODEL_MATRIX * vec4(0.0, 0.0, 0.0, 1.0);
    float time = TIME * speed + offset;
    //float time = TIME * speed + pos.x * pos.y  ; not working when moving...
    VERTEX.x += getWind(VERTEX.xy, UV, time);
}
