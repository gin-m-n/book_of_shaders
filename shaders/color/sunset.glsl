#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;

vec3 colorA = vec3(0.149, 0.141, 0.912);
vec3 colorB = vec3(0.8745, 0.4784, 0.1529);

float shape(vec2 st) {
    float a = sin(PI / 2.0 * st.y);
    return a;
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    
    vec3 color = vec3(0.0);
    
    float pct = shape(st);
    
    // Mix uses pct (a value from 0-1) to
    // mix the two colors
    color = mix(colorA, colorB, pct);
    
    gl_FragColor = vec4(color, 1.0);
}
