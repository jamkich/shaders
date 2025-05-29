
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float circle(in vec2 st, in float edge1, in float edge2, in vec2 pos) {
    float pct = 0.;
    vec2 toCenter = pos - st;
    //pct = smoothstep(0.0,1., length(toCenter));
    //pct = 1. - step(0.5, length(toCenter));

    pct = 1. - smoothstep(edge1, edge2, length(toCenter));
    return pct;
}

float cheaperCircle(in vec2 _st, in float _radius) {
    vec2 dist = _st - vec2(0.5);
    return 1. - smoothstep(_radius - (_radius * 0.01),
            _radius + (_radius * 0.01),
            dot(dist, dist) * 4.0);
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;

    float circle_mask_1 = circle(st, 0.4 * (sin(u_time * 2.1)), 0.5, vec2(0.5, 0.5));
    float circle_mask_2 = circle(st, 0.7 * (sin(u_time + st.x * 1.2)) * 2., 0.5, vec2(0.4, 0.6));
    float circle_mask_3 = circle(st, 0.5, 0.4 * cos(u_time) * sin(u_time * st.y), vec2(0.6, 0.7));
    float circle_mask_4 = circle(st, 0.2 * cos(u_time), 0.2 * sin(u_time), vec2(0.2, 0.5));

    // v2
    //  float circle_mask_1 = circle(st, 0.4 * (sin(u_time * 2.1)), 0.5, vec2(0.3, 0.7));
    //  float circle_mask_2 = circle(st, 0.7 * (sin(u_time + st.x * 1.2)) * 2., 0.5, vec2(0.4, 0.6));
    // float circle_mask_3 = circle(st, 0.5 , 0.4 * cos(u_time) * sin(u_time * st.y) , vec2(0.6, 0.7));
    //  float circle_mask_4 = circle(st, 0.5* cos(u_time), 0.4 * sin(u_time), vec2(0.7, 0.2));

    vec3 color_1 = vec3(circle_mask_1) * vec3(0.491, 0.950, 0.645);
    vec3 color_2 = vec3(circle_mask_2 * vec3(0.815, 0.110, 0.373));
    vec3 color_3 = vec3(circle_mask_3 * vec3(0.915, 0.258, 0.188));
    vec3 color_4 = vec3(circle_mask_4 * vec3(0.137, 0.132, 0.185));

    // v2
    // vec3 color_1 = vec3(circle_mask_1) * vec3(0.341, 0.175, 0.950);
    // vec3 color_2 = vec3(circle_mask_2 * vec3(0.815, 0.110, 0.373));
    // vec3 color_3 = vec3(circle_mask_3 * vec3(0.466, 0.915, 0.000));
    // vec3 color_4 = vec3(circle_mask_4 * vec3(0.895, 0.837, 0.371));

    vec3 color = (color_1 + color_2 + color_3 + color_4) * 0.35;

    gl_FragColor = vec4(color, 1.0);
}
