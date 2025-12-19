// https://gist.github.com/showa-yojyo/9ca41224f478fa5ffd8374da57d30e89

#ifdef GL_ES
precision mediump float;
#endif

#define TWO_PI 6.28318530718

uniform vec2 u_resolution;
uniform float u_time;

//  Function from Iñigo Quiles
//  https://www.shadertoy.com/view/MsS3Wc
vec3 hsb2rgb(in vec3 c) {
    vec3 rgb = clamp(
        abs(mod(c.x * 6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0,
        0.0,
        1.0
    );
    rgb = rgb * rgb * (3.0 - 2.0 * rgb);
    return c.z * mix(vec3(1.0), rgb, c.y);
}

float pulse(float a, float b, float x) {
    return step(a, x) - step(b, x);
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    vec3 color = vec3(0.0);
    
    // Use polar coordinates instead of cartesian
    vec2 toCenter = vec2(0.5) - st;
    float angle = atan(toCenter.y, toCenter.x);
    float radius = length(toCenter) * 2.0;
    
    float hue = angle / TWO_PI + 0.5;
    
    float d = 0.1;
    float x1 = d;
    float x2 = 1.0 - d;
    float y1 = (1.0 - d) * 0.5;
    float y2 = (1.0 + d) * 0.5;
    
    hue = pulse(0.0, x1, hue) * mix(0.0, y1, hue / d)
    + pulse(x1, x2, hue) * mix(y1, y2, (hue - x1) / (x2 - x1))
    + pulse(x2, 1.0, hue) * mix(y2, 1.0, (hue - x2) / (1.0 - x2));
    
    color = hsb2rgb(vec3(hue, radius, 1.0));
    
    gl_FragColor = vec4(color, 1.0);
}