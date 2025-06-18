vec2 makeGrid(in vec2 st, in float countX, in float countY) {
    st.x *= countX;
    st.y *= countY;
    st = fract(st);
    return st;
}

// Tic-tac-toe
vec2 makeGrid(in vec2 st, in float countX, in float countY, out vec2 cell) {
    st.x *= countX;
    st.y *= countY;
    cell = floor(st);
    st = fract(st);
    return st;
}
void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    vec3 color = vec3(0.0);

    vec2 cell;
    vec2 global_st = st;
    st = makeGrid(st, 3., 3., cell);
    //color = vec3(st,0.0);

    float row = 2.0 - cell.y;
    float col = cell.x;

    if (row == 2.0 && col == 0.) {
        color = vec3(circle(st, 0.3));
    } else if (row == 2.0 && col == 1.) {
        color = vec3(cross(st, 0.5));
    } else if (row == 2.0 && col == 2.) {
        color = vec3(circle(st, 0.3));
    } else if (row == 1.0 && col == 0.) {
        color = vec3(circle(st, 0.3));
    } else if (row == 1.0 && col == 1.) {
        color = vec3(circle(st, 0.3));
    } else if (row == 1.0 && col == 2.) {
        color = vec3(cross(st, 0.5));
    } else if (row == 0.0 && col == 0.) {
        color = vec3(cross(st, 0.5));
    } else if (row == 0.0 && col == 1.) {
        color = vec3(circle(st, 0.3));
    } else if (row == 0.0 && col == 2.) {
        color = vec3(cross(st, 0.5));
    }

    float pct1 = global_st.x;
    float line1 = plot(global_st, pct1);

    float pct2 = 1.0 - global_st.x;
    float line2 = plot(global_st, pct2);

    float lines = max(line1, line2);

    color = mix(color, vec3(1.0, 0.0, 0.0), lines);

    gl_FragColor = vec4(color, 1.0);
}

// Author @patriciogv ( patriciogonzalezvivo.com ) - 2015

#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265358979323846

uniform vec2 u_resolution;
uniform float u_time;

vec2 rotate2D(vec2 _st, float _angle) {
    _st -= 0.5;
    _st = mat2(cos(_angle), -sin(_angle),
            sin(_angle), cos(_angle)) * _st;
    _st += 0.5;
    return _st;
}

vec2 tile(vec2 _st, float _zoom) {
    _st *= _zoom;
    return fract(_st);
}

vec2 rotateTilePattern(vec2 _st) {

    //  Scale the coordinate system by 2x2
    _st *= 2.0;

    //  Give each cell an index number
    //  according to its position
    float index = 0.0;
    index += step(1., mod(_st.x, 2.0));
    index += step(1., mod(_st.y, 2.0)) * 2.0;

    //      |
    //  2   |   3
    //      |
    //--------------
    //      |
    //  0   |   1
    //      |

    // Make each cell between 0.0 - 1.0
    _st = fract(_st);

    // Rotate each cell according to the index
    if (index == 1.0) {
        //  Rotate cell 1 by 90 degrees
        _st = rotate2D(_st, PI * 0.5);
    } else if (index == 2.0) {
        //  Rotate cell 2 by -90 degrees
        _st = rotate2D(_st, PI * -0.5);
    } else if (index == 3.0) {
        //  Rotate cell 3 by 180 degrees
        _st = rotate2D(_st, PI);
    }

    return _st;
}

void main(void) {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;

    st = tile(st, 3.0);
    st = rotateTilePattern(st);

    st = rotate2D(st, u_time);
    st = rotateTilePattern(sin(st));

    // step(st.x,st.y) just makes a b&w triangles
    // but you can use whatever design you want.
    gl_FragColor = vec4(vec3(step(st.x, st.y * PI)) * vec3(sin(u_time), 0.3, 0.5), 1.0);
}
