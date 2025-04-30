shader_type canvas_item;

uniform float strength = 10.0;
uniform float time_scale = 20.0;

void fragment() {
    vec2 uv = UV;
    float glitch = step(0.5, fract(sin(uv.y * strength + TIME * time_scale) * 43758.5453));
    uv.x += glitch * 0.02 * sin(TIME * 100.0);
    COLOR = texture(TEXTURE, uv);
}
