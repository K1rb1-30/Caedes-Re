shader_type canvas_item;

void fragment() {
    vec2 center = vec2(0.5, 0.5); // Centro del sprite
    float radius = 0.5; // Radio del círculo (ajustable)

    vec2 uv = UV;
    vec2 diff = uv - center;

    if (length(diff) > radius) {
        discard; // Hace transparente fuera del círculo
    }

    COLOR = texture(TEXTURE, uv);
}