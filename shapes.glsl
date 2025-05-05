#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float rectangle(in vec2 st, in vec2 bottomLeftBounds, in vec2 topRightBounds) {
    // bottom-left
    vec2 bl = floor(st - bottomLeftBounds + 1.);
    float pct = bl.x * bl.y;

    // top-right
    vec2 tr = floor(1.0 - st - topRightBounds + 1.0);
    pct *= tr.x * tr.y;

    return pct;
}

float outline(in vec2 st, in vec2 bottomLeftBounds, in vec2 topRightBounds, float thickness) {
    float outerMask = rectangle(st, bottomLeftBounds, topRightBounds);

    vec2 inBottomLeft = bottomLeftBounds + vec2(thickness);
    vec2 inTopRight = topRightBounds + vec2(thickness);

    float inMask = rectangle(st, inBottomLeft, inTopRight);

    float outlineMask = clamp(outerMask - inMask, 0.1, 1.);

    return outlineMask;
}

void main() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    vec3 color = vec3(0.0);

    float rectangleMask1 = rectangle(st, vec2(0.2, 0.3), vec2(0.4, 0.1));

    float outlineMask1 = outline(st, vec2(0.1, 0.4), vec2(0.2, 0.3), 0.002);

    vec3 color1 = vec3(rectangleMask1);
    vec3 color2 = vec3(outlineMask1);

    color = color1 + color2;

    gl_FragColor = vec4(color, 1.0);
}
