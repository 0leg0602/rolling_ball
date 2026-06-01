shader_type canvas_item;

void fragment() {
    // Get the original color of the texture at the current pixel
    vec4 tex_color = texture(TEXTURE, UV);
    
    // Calculate the grayscale luminosity using standard weights
    float luma = dot(tex_color.rgb, vec3(0.3, 0.4, 0.114));
    
    // Output the grayscale color while preserving the original alpha (transparency)
    COLOR = vec4(vec3(luma), tex_color.a);
}