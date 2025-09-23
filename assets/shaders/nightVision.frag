#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 iResolution;
uniform float iTime;
uniform sampler2D iChannel0;

out vec4 fragColor;

float RGB2Luminance(in vec3 rgb)
{
    return 0.2126 * rgb.r + 0.7152 * rgb.g + 0.0722 * rgb.b;
}

void main()
{
    // common stuff
    vec2 uv = gl_FragCoord.xy / iResolution.xy;
    vec2 pixelSize = vec2(1.0) / iResolution.xy;

    // sobel stuff
    float tl = RGB2Luminance(texture(iChannel0, uv + -pixelSize.xy).rgb);
    float t = RGB2Luminance(texture(iChannel0, uv + vec2(0.0, -pixelSize.y)).rgb);
    float tr = RGB2Luminance(texture(iChannel0, uv + vec2(pixelSize.x, -pixelSize.y)).rgb);

    float cl = RGB2Luminance(texture(iChannel0, uv + vec2(-pixelSize.x, 0.0)).rgb);
    float c = RGB2Luminance(texture(iChannel0, uv).rgb);
    float cr = RGB2Luminance(texture(iChannel0, uv + vec2(pixelSize.x, 0.0)).rgb);

    float bl = RGB2Luminance(texture(iChannel0, uv + vec2(-pixelSize.x, pixelSize.y)).rgb);
    float b = RGB2Luminance(texture(iChannel0, uv + vec2(0.0, pixelSize.y)).rgb);
    float br = RGB2Luminance(texture(iChannel0, uv + vec2(pixelSize.x, pixelSize.y)).rgb);

    float sobelX = tl * -1.0 + tr * 1.0 + cl * -2.0 + cr * 2.0 + bl * -1.0 + br * 1.0;
    float sobelY = tl * -1.0 + t * -2.0 + tr * -1.0 + bl * 1.0 + b * 2.0 + br * 1.0;

    float sobel = sqrt(sobelX * sobelX + sobelY * sobelY);

    // 야간 투시경 효과를 위한 전체 이미지 톤 조정
    // 원본 이미지의 휘도(밝기)를 계산합니다.
    vec4 textureColor = texture(iChannel0, uv);
    float luminance = RGB2Luminance(textureColor.rgb);

    // 휘도에 따라 녹색 계열 색상으로 변환합니다.
    // 밝은 부분은 밝은 녹색으로, 어두운 부분은 어두운 녹색으로 만듭니다.
    vec3 nightVisionColor = vec3(0.0, 1.0, 0.0) * luminance;

    // 윤곽선(sobel) 값에 따라 녹색 에지 색상을 결정합니다.
    float sobelFactor = smoothstep(0.0, 0.7, sobel);
    vec3 edgeColor = mix(vec3(0.0), vec3(0.0, 1.0, 0.0), sobelFactor);

    // 최종적으로 윤곽선 색상을 야간 투시경 색상에 섞습니다.
    // 윤곽선이 뚜렷할수록 에지 색상이 강하게 적용됩니다.
    vec3 finalColor = mix(nightVisionColor, edgeColor, sobelFactor);

    // 최종 색상을 출력합니다.
    fragColor = vec4(finalColor, 1.0);
}