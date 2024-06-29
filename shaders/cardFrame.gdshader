shader_type canvas_item;

uniform vec4 neon_color = vec4(0.0, 0.0, 1.0, 1.0); // Neon blue color
uniform float border_width : hint_range(0.0, 10.0) = 3.0;

void fragment() {
    vec2 uv = FRAGCOORD.xy / SCREEN_PIXEL_SIZE;
    vec2 tex_size = vec2(textureSize(TEXTURE, 0));
    vec2 frag_coord = uv * tex_size;

    float border = border_width;
    vec4 tex_color = texture(TEXTURE, FRAGCOORD.xy / SCREEN_PIXEL_SIZE);

    if (frag_coord.x < border || frag_coord.x > tex_size.x - border ||
        frag_coord.y < border || frag_coord.y > tex_size.y - border) {
        COLOR = neon_color;
    } else {
        COLOR = tex_color;
    }
}
