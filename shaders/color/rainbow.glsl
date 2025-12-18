#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform float u_time;

vec3 r = vec3(1.0, 0.0, 0.0);
vec3 g = vec3(0.0, 1.0, 0.0);
vec3 b = vec3(0.0, 0.0, 1.0);

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    float N = 3.0;
    
    vec3 color =
    (step(0.0 / N, st.y) - step(1.0 / N, st.y))
    * mix(r, g, st.y * N)
    + (step(1.0 / N, st.y) - step(2.0 / N, st.y))
    * mix(g, b, (st.y - 1.0 / N) * N)
    + (step(2.0 / N, st.y) - step(3.0 / N, st.y))
    * mix(b, r, (st.y - 2.0 / N) * N);
    
    gl_FragColor = vec4(color, 1.0);
}
