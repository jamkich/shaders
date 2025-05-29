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
