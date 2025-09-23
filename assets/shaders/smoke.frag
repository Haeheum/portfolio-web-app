#version 460 core

#include <flutter/runtime_effect.glsl>

precision highp float;

uniform float uWidth;
uniform float uHeight;
uniform float uTime;
uniform sampler2D uTexture; // me.jpeg 이미지가 들어옴

out vec4 fragColor;

vec2 normCoord(vec2 fc) {
    return fc / vec2(uWidth, uHeight);
}

// 2D Perlin Noise 함수 (기존과 동일)
float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

// FBM (Fractal Brownian Motion) - 여러 옥타브의 노이즈를 합쳐 더 복잡한 연기 패턴 생성
float fbm(vec2 p) {
    float sum = 0.0;
    float amp = 0.5;
    float freq = 1.0;
    for (int i = 0; i < 4; ++i) {
        sum += noise(p * freq) * amp;
        freq *= 2.0;
        amp *= 0.5;
    }
    return sum;
}


void main() {
    vec2 uv = normCoord(gl_FragCoord.xy);

    // 1. 연기 자체의 밀도 계산 (FBM 노이즈와 시간 이용)
    // 시간이 지남에 따라 연기가 위로 올라가는 듯한 효과를 위해 uv.y에 시간을 더함
    vec2 p = uv * 3.0; // 노이즈 스케일 조정
    p.y -= uTime * 0.1; // 연기가 위로 흐르는 효과 (y축으로 이동)
    p.x += sin(uTime * 0.05 + uv.y * 5.0) * 0.1; // 연기가 좌우로 흔들리는 효과

    float smokeDensity = fbm(p + fbm(p * 2.0) * 0.5); // 노이즈에 노이즈를 더해 더 유기적인 패턴 생성

    // 연기의 밀도 조정 (smoothstep을 사용하여 부드럽게 자르고 강조)
    smokeDensity = smoothstep(0.1, 1.0, smokeDensity); // 연기 밀도 범위 조정 (시작점, 끝점)

    // 2. me.jpeg 이미지를 배경으로 깔고, 연기 밀도에 따라 이미지 위에 연기 덮기
    vec4 imageColor = texture(uTexture, uv);

    // 연기 색상 (예: 회색 연기)
    vec3 smokeColor = vec3(0.8, 0.8, 0.8);

    // 최종 색상: 이미지 위에 연기 색상을 alpha 블렌딩
    // smokeDensity가 높을수록 연기가 더 많이 보임
    fragColor = mix(imageColor, vec4(smokeColor, 1.0), smokeDensity * 1.0); // 0.6은 연기의 불투명도 조절

}