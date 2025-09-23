#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 uResolution;
uniform float uTime;
uniform sampler2D uImage;
uniform vec2 uClickPosition;
uniform float uClickTime;

out vec4 fragColor;

void main() {
    // 현재 픽셀의 UV 좌표 (0.0 ~ 1.0)
    vec2 uv = FlutterFragCoord().xy / uResolution.xy;

    // 클릭이 아직 발생하지 않았거나, 리플 애니메이션이 종료된 경우
    // 원래 이미지를 그대로 반환합니다.
    float timeSinceClick = uTime - uClickTime;
    if (uClickPosition.x < 0.0 || timeSinceClick > 2.0) {
        fragColor = texture(uImage, uv);
    }

    // 클릭 위치를 중심으로 UV 좌표를 조정합니다.
    vec2 click_uv = uClickPosition;
    vec2 distVec = uv - click_uv;

    // 리플 효과의 강도와 모양을 계산합니다.
    float dist = length(distVec);
    float wave_speed = 1.5;
    float wave_strength = 0.01;

    // 리플 애니메이션의 현재 위치를 계산합니다.
    float wave_pos = dist - timeSinceClick * wave_speed;

    // sin 함수로 파형을 만들고, smoothstep으로 부드러운 시작과 끝을 만듭니다.
    float ripple = sin(wave_pos * 20.0) * wave_strength * (1.0 - smoothstep(0.0, 1.0, timeSinceClick / 2.0));

    // 리플 효과를 적용하여 픽셀의 위치를 왜곡합니다.
    vec2 offsetUV = uv + normalize(distVec) * ripple;

    // 최종 색상을 계산합니다.
    fragColor = texture(uImage, offsetUV);
}