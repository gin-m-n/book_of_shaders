#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float plot(vec2 st, float plot) {
    float diff = 0.05;
    return smoothstep(plot - diff, plot, st.y) - smoothstep(plot, plot + diff, st.y);
}

void main() {
    float scale = 4.0;
    vec2 st = gl_FragCoord.xy / u_resolution * scale - scale / 2.0 ;
    
    float y = sin(st.x * 2.0 * PI);
    
    vec3 color = vec3(0.0);
    
    float pct = plot(st, y);
    color = (1.0 - pct) * color + pct * vec3(0.0, 1.0, 0.0);
    
    float xZero = smoothstep(-0.01, 0.0, st.x) - smoothstep(0.0, 0.01, st.x);
    color = color + xZero * vec3(1.0, 0, 0);
    float yZero = smoothstep(-0.01, 0.0, st.y) - smoothstep(0.0, 0.01, st.y);
    color = color + yZero * vec3(1.0, 0, 0);
    
    float xMinus1 = smoothstep(-1.01, - 1.0, st.x) - smoothstep(-1.0, - 0.99, st.x);
    color = color + xMinus1 * vec3(1.0);
    float xPlus1 = smoothstep(0.99, 1.0, st.x) - smoothstep(1.0, 1.01, st.x);
    color = color + xPlus1 * vec3(1.0);
    
    float yMinus1 = smoothstep(-1.01, - 1.0, st.y) - smoothstep(-1.0, - 0.99, st.y);
    color = color + yMinus1 * vec3(1.0);
    float yPlus1 = smoothstep(0.99, 1.0, st.y) - smoothstep(1.0, 1.01, st.y);
    color = color + yPlus1 * vec3(1.0);
    
    gl_FragColor = vec4(color, 1.0);
}
