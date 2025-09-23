#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float iTime;
uniform sampler2D uTexture;

out vec4 fragColor;

void main() {
    // 1. 원본 이미지 색상 가져오기
    vec2 fragCoord = FlutterFragCoord().xy; // 현재 픽셀 좌표 (좌측 하단이 0,0)
    vec2 uv = fragCoord / uSize; // 0.0 ~ 1.0 범위의 UV 좌표
    vec4 imageColor = texture(uTexture, uv);

    // 2. ShaderToy 코드 포팅 (중앙 기준 좌표계 사용)
    // uSize를 vec2로 명시적으로 사용 (uSize.x, uSize.y)
    vec2 v = uSize;

    // 픽셀 좌표를 중앙을 (0,0)으로 하는 좌표계로 변환
    // 1. 정규화 (0.0 ~ 1.0)
    // 2. 중앙 이동 (-0.5를 하여 -0.5 ~ 0.5 범위로 만듦)
    vec2 centered_uv = fragCoord / v - 0.5;

    // ShaderToy의 u 변수에 중앙 기준 좌표계를 적용
    vec2 u = centered_uv * v; // u 변수를 중앙 기준의 픽셀 좌표로 설정

    // ShaderToy의 v 변수 초기화 (원본 코드에 맞춰 v.y 사용)
    u = .2 * (u + u - v) / v.y; // 이 부분은 기존 로직을 유지합니다.

    vec4 z, o = vec4(1, 2, 3, 0);
    z = o;

    float a = .5;
    float t = iTime;

    // --- ShaderToy 루프 부분 ---
    for (float i = 0.0; i < 11.0; ++i) {
        a += .03;
        // v 업데이트 시 centered_uv가 아닌, 현재 u를 사용합니다.
        v = cos(++t - 7. * u * pow(a, i)) - 5. * u;

        // o 업데이트 시, u.yx는 centered_uv 기준이 아닌, 현재 u 기준으로 사용합니다.
        o += (1. + cos(z + t)) / length((1. + i * dot(v, v)) * sin(1.5 * u / (.5 - dot(u, u)) - 9. * u.yx + t));

        mat2 rotationMatrix = mat2(cos(i + .02 * t - vec4(0, 11, 33, 0)));
        vec2 u_temp = u * rotationMatrix;

        vec2 term1 = tanh(40. * u_temp * cos(1e2 * u_temp.yx + t)) / 2e2;
        vec2 term2 = .2 * a * u;

        vec2 exp_val = vec2(exp(dot(o, o) / 1e2));
        vec2 term3 = cos(4.0 / exp_val + t) / 3e2;

        u += term1 + term2 + term3;
    }

    // --- 최종 색상 계산 ---
    o = 25.6 / (min(o, 13.) + 164. / o) - dot(u, u) / 250.;

    // 3. 결과 혼합
    fragColor = mix(imageColor, o, clamp(o.r * 0.7, 0.0, 1.0));
}