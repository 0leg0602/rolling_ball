shader_type sky;

uniform float animation_speed = 0.1;

float hash(vec3 p) {
    p = fract(sin(p) * 432758.5453);
    return fract(p.x + p.y + p.z);
}

float noise3d(vec3 p) {
    vec3 i = floor(p);
    vec3 f = fract(p);
    f = f * f * (3.0 - 2.0 * f);

    return mix(
        mix(mix(hash(i + vec3(0,0,0)), hash(i + vec3(1,0,0)), f.x),
            mix(hash(i + vec3(0,1,0)), hash(i + vec3(1,1,0)), f.x), f.y),
        mix(mix(hash(i + vec3(0,0,1)), hash(i + vec3(1,0,1)), f.x),
            mix(hash(i + vec3(0,1,1)), hash(i + vec3(1,1,1)), f.x), f.y), 
        f.z
    );
}

void sky() {
    vec3 direction = EYEDIR * 1.0;
	direction.y += TIME * animation_speed;
	direction.x += TIME * animation_speed;
    float n = noise3d(direction);
	if (n < 0.5) {
		n = 1.0 - n;
	}
    
    COLOR = vec3(0.0, n * 0.5, n);
}