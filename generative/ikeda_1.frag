// Author @jamkich - 2025
// Title:

float random(in float x) {
    return fract(sin(x));
}

float randomHuge(in vec2 _coord) {
    return fract(sin(dot(_coord.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 coords = fragCoord.xy / iResolution.xy;

    coords.x *= fragCoord.x / iResolution.y;

    vec2 ipos = floor(coords);
    vec2 fpos = fract(coords);

    if (fpos.x > 0.5) {
        vec3 color = vec3(randomHuge(floor(coords) * tan(vec2(323., 6.4))) ;
        fragColor = vec4(color, 1.0) * iTime;
    } else if (fpos.y > 0.5) {
        vec3 color = vec3(randomHuge(ipos));
        fragColor = vec4(color, 1.0);
    }
}
