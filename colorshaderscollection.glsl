// painting gradient
#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 colorA = vec3(0.149, 0.141, 0.912);
vec3 colorB = vec3(1.000, 0.833, 0.224);

float plot(vec2 st, float pct) {
    return smoothstep(pct - 0.01, pct, st.y) -
        smoothstep(pct, pct + 0.01, st.y);
}

// https : //thebookofshaders.com/06/
void painting() {
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    vec3 color = vec3(0.0);

    vec3 pct = vec3(st.x);

    pct.r = smoothstep(0.0, 1., st.x * PI);
    pct.g = sin(st.x * PI) - 0.08;
    //pct.b = pow(min(1.,st.x),0.5) + 0.1;
    pct.b = pow(st.x, 0.2) - 0.05;

    color = mix(colorA, colorB, pct);

    // Plot transition lines for each channel
    color = mix(color, vec3(1.0, 0.0, 0.0), plot(st, pct.r));
    color = mix(color, vec3(0.0, 1.0, 0.0), plot(st, pct.g));
    color = mix(color, vec3(0.0, 0.0, 1.0), plot(st, pct.b));

    gl_FragColor = vec4(color, u_time);
}

// acid beacon
#ifdef GL_ES
precision mediump float;
#endif

#define TWO_PI 6.28318530718

uniform vec2 u_resolution;
uniform float u_time;

//  Function from Iñigo Quiles
//  https://www.shadertoy.com/view/MsS3Wc
vec3 hsb2rgb(in vec3 c) {
    vec3 rgb = clamp(abs(mod(c.x * 6.0 + vec3(0.0, 4.0, 2.0),
                    6.0) - 3.0) - 1.0,
            0.0,
            1.0);
    rgb = rgb * rgb * (3.0 - 2.0 * rgb);
    return c.z * mix(vec3(1.0), rgb, c.y);
}

void beacon() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    vec3 color = vec3(0.);

    // Use polar coordinates instead of cartesian
    vec2 toCenter = vec2(0.5) - st * 2.;
    float angle = atan(toCenter.y, toCenter.x) + u_time;
    float radius = sin(length(toCenter) * pow(TWO_PI, 2.));

    color = sin(hsb2rgb(vec3((angle / TWO_PI) + pow(u_time, 0.5), radius - TWO_PI, st.y)));

    gl_FragColor = vec4(color, 1.0);
}

// spinning death
void death() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    vec3 color = vec3(0.);

    // Use polar coordinates instead of cartesian
    vec2 toCenter = vec2(0.5) - st;
    float angle = atan(toCenter.y, toCenter.x) + u_time;
    float radius = sin(length(toCenter) * TWO_PI);

    color = smoothstep(0.5, 1., (hsb2rgb(vec3((angle / TWO_PI) + 0.5, radius, sin(st.y - u_time)))));

    gl_FragColor = vec4(color, 1.0);
}

// spinning imagination
void imagination() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    vec3 color = vec3(0.);

    // Use polar coordinates instead of cartesian
    vec2 toCenter = vec2(0.5) - st;
    float angle = atan(toCenter.y, toCenter.x) + u_time;
    float radius = sin(length(toCenter) * TWO_PI);

    // Map the angle (-PI to PI) to the Hue (from 0 to 1)
    // and the Saturation to the radiuTs
    color = smoothstep(0.5, 1., sin(hsb2rgb(vec3((angle / TWO_PI) + 0.5, radius, u_time))));

    gl_FragColor = vec4(color, 1.0);
}

// spinning ring
void main() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    vec3 color = vec3(0.);

    // Use polar coordinates instead of cartesian
    vec2 toCenter = vec2(0.5) - st;
    float angle = atan(toCenter.y, toCenter.x) + u_time;
    float radius = sin(length(toCenter) * 2. * TWO_PI);

    color = hsb2rgb(vec3((angle / TWO_PI) + pow(u_time, 0.5), radius * TWO_PI, st.y));

    gl_FragColor = vec4(color, 1.0);
}

// vol .2

void spinning_ring_2() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    vec3 color = vec3(0.);

    // Use polar coordinates instead of cartesian
    vec2 toCenter = vec2(0.5) - st;
    float angle = atan(toCenter.y, toCenter.x) + u_time;
    float radius = sin(length(toCenter) * 2. * TWO_PI);

    color = hsb2rgb(vec3((angle / TWO_PI) + pow(u_time, 0.5), radius * TWO_PI, st.y));

    gl_FragColor = vec4(abs(sin(color)), 1.0);
}

// wow
void wow() {
    vec2 st = gl_FragCoord.xy / u_resolution;
    vec3 color = vec3(0.0);

    // Use polar coordinates instead of cartesian
    vec2 toCenter = vec2(0.5) - st;
    float angle = atan(toCenter.y, toCenter.x);
    float radius = sin(length(toCenter) * TWO_PI);

    // Map the angle (-PI to PI) to the Hue (from 0 to 1)
    // and the Saturation to the radiuTs
    color = hsb2rgb(vec3((angle / TWO_PI * u_time) + 0.5, radius, 1.));

    gl_FragColor = vec4(color, 1.0);
}
