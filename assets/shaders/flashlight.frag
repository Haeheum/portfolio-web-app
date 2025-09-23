#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 uResolution;
uniform float uTime;
uniform vec2 uMouse;      // (0.0 ~ 1.0) 범위
uniform sampler2D uTexture;

out vec4 fragColor;

void main() {
    // 현재 픽셀의 UV 좌표 (0.0 ~ 1.0)
    vec2 uv = FlutterFragCoord().xy / uResolution.xy;

    // 마우스가 화면 안에 있을 때만 효과 적용
    if (!(uMouse.x >= 0.0 && uMouse.x <= 1.0 &&
    uMouse.y >= 0.0 && uMouse.y <= 1.0)) {
        fragColor = vec4(texture(uTexture, uv).rgb * 0.2, 1.0);
        return;
    }

    vec4 originalColor = texture(uTexture, uv);

    // --- 좌표 변환 (NDC: -1 ~ 1) ---
    float aspect_ratio = uResolution.x / uResolution.y;

    vec2 uv_ndc    = (uv * 2.0 - 1.0) * vec2(aspect_ratio, 1.0);
    vec2 mouse_ndc = (uMouse * 2.0 - 1.0) * vec2(aspect_ratio, 1.0);

    // 거리 계산
    float dist_to_mouse = length(uv_ndc - mouse_ndc);

    // --- 빛의 강도 계산 ---
    const float exposure = 3.0;  // 빛의 밝기
    const float AOE = 6.0;      // 빛의 크기 (값이 클수록 좁아짐)

    float finalIntensity = exp(-(dist_to_mouse * AOE)) * exposure;

    // --- 색상 혼합 ---
    vec4 darkColor   = vec4(originalColor.rgb * 0.2, 1.0);
    vec4 brightColor = originalColor;

    fragColor = mix(darkColor, brightColor, finalIntensity);
}
