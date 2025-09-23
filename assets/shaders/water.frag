#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float uTime;
uniform sampler2D uTexture;

out vec4 fragColor;

vec4 fragment(vec2 uv) {
    float waterLevel = 0.7;
    vec4 waterColor = vec4(1.0);
    vec2 reflectedUV = uv.xy;
    if (uv.y >= waterLevel) {
        reflectedUV.y = 2.0 * waterLevel - reflectedUV.y;
        reflectedUV.y = reflectedUV.y + cos(1. / (uv.y - waterLevel) + uTime * 2.0) * 0.015;
        waterColor = vec4(0.7, 0.85, 1.0, 1.0);
    }

    return texture(uTexture, reflectedUV) * waterColor;
}

void main() {
    vec2 uv = FlutterFragCoord().xy / uSize;
    fragColor = fragment(uv);
}