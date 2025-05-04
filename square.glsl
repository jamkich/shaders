#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float square(in vec2 st, in float pam1, in float pam2) {
    // bottom-left
    vec2 bl = floor(st - pam1 + 1.);
    float pct = bl.x * bl.y;

    // top-right
    vec2 tr = floor(1.0 - st - pam2 + 1.0);
    pct *= tr.x * tr.y;

    return pct;
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    vec3 color = vec3(0.0);

    float square_mask_1 = square(st, 0.9, 0.05);
    float square_mask_2 = square(st, 0.4, 0.2);
    float square_mask_3 = square(st, 0.05, 0.8);

    vec3 color_1 = vec3(square_mask_1);
    vec3 color_2 = vec3(square_mask_2);
    vec3 color_3 = vec3(square_mask_3);

    color = color_1 + color_2 + color_3;

    gl_FragColor = vec4(color, 1.0);
}
