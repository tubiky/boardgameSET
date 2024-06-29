shader_type canvas_item;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    if (tex_color.rgb == vec3(0.0, 0.0, 0.0)) {
        tex_color.rgb = vec3(0.0, 1.0, 0.0);  // 녹색으로 변경
    }
    COLOR = tex_color;
}