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

    vec3 white = vec3(249.0 / 255.0, 242.0 / 255.0, 224.0 / 255.0);
    vec3 red = vec3(182. / 255.0, 38. / 255.0, 38. / 255.0);
    vec3 yellow = vec3(250. / 255.0, 201. / 255.0, 32. / 255.0);
    vec3 blue = vec3(0., 94. / 255., 155. / 255.);
    float vertical_spacing = 0.21;

    // first row
    float rectangleMask1 = rectangle(st, vec2(0., 0.82), vec2(0.95, 0.0));
    float rectangleMask2 = rectangle(st, vec2(0.08, 0.82), vec2(0.8, 0.0));
    float rectangleMask3 = rectangle(st, vec2(0.232, 0.82), vec2(0.25, 0.0));
    float rectangleMask4 = rectangle(st, vec2(0.79, 0.82), vec2(0.05, 0.0));
    float rectangleMask5 = rectangle(st, vec2(0.98, 0.82), vec2(0., 0.0));

    // second row
    float rectangleMask6 = rectangle(st, vec2(0., 0.82 - vertical_spacing), vec2(0.95, 0.0 + vertical_spacing));
    float rectangleMask7 = rectangle(st, vec2(0.08, 0.82 - vertical_spacing), vec2(0.8, 0. + vertical_spacing));
    float rectangleMask8 = rectangle(st, vec2(0.232, 0.82 - vertical_spacing), vec2(0.25, 0.0 + vertical_spacing));
    float rectangleMask9 = rectangle(st, vec2(0.79, 0.82 - vertical_spacing), vec2(0.05, 0. + vertical_spacing));
    float rectangleMask10 = rectangle(st, vec2(0.98, 0.82 - vertical_spacing), vec2(0., 0. + vertical_spacing));

    // third+ row
    float rectangleMask11 = rectangle(st, vec2(0.0, 0.82 - vertical_spacing * 4.), vec2(0.8, 0.0 + vertical_spacing * 2.));
    float rectangleMask12 = rectangle(st, vec2(0.232, 0.82 - vertical_spacing * 3.5), vec2(0.25, 0.0 + vertical_spacing * 2.));
    float rectangleMask13 = rectangle(st, vec2(0.79, 0.82 - vertical_spacing * 3.5), vec2(0.05, 0. + vertical_spacing * 2.));
    float rectangleMask14 = rectangle(st, vec2(0.98, 0.82 - vertical_spacing * 3.5), vec2(0., 0. + vertical_spacing * 2.));

    // fourth row
    float rectangleMask15 = rectangle(st, vec2(0.232, 0.82 - vertical_spacing * 4.5), vec2(0.25, 0.0 + vertical_spacing * 4.5));
    float rectangleMask16 = rectangle(st, vec2(0.79, 0.82 - vertical_spacing * 4.5), vec2(0.05, 0. + vertical_spacing * 4.5));
    float rectangleMask17 = rectangle(st, vec2(0.98, 0.82 - vertical_spacing * 4.), vec2(0., 0. + vertical_spacing * 4.5));

    vec3 color1 = vec3(rectangleMask1) * red;
    vec3 color2 = vec3(rectangleMask2) * red;
    vec3 color3 = vec3(rectangleMask3) * white;
    vec3 color4 = vec3(rectangleMask4) * white;
    vec3 color5 = vec3(rectangleMask5) * yellow;

    vec3 color6 = vec3(rectangleMask6) * red;
    vec3 color7 = vec3(rectangleMask7) * red;
    vec3 color8 = vec3(rectangleMask8) * white;
    vec3 color9 = vec3(rectangleMask9) * white;
    vec3 color10 = vec3(rectangleMask10) * yellow;

    vec3 color11 = vec3(rectangleMask11) * white;
    vec3 color12 = vec3(rectangleMask12) * white;
    vec3 color13 = vec3(rectangleMask13) * white;
    vec3 color14 = vec3(rectangleMask14) * white;

    vec3 color15 = vec3(rectangleMask15) * white;
    vec3 color16 = vec3(rectangleMask16) * blue;
    vec3 color17 = vec3(rectangleMask17) * blue;

    vec3 mainColor = vec3(0.0);
    mainColor = color1 + color2 + color3 + color4 + color5 + color6 + color7 + color8 + color9 + color10 + color11 + color12 + color13 + color14 + color15 + color16 + color17;

    gl_FragColor = vec4(mainColor, 1.0);
}
