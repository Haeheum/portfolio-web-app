import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

import '../../data/shader_repository.dart';

class ShaderPixelation extends StatefulWidget {
  const ShaderPixelation({super.key});

  @override
  State<ShaderPixelation> createState() => _ShaderPixelationState();
}

class _ShaderPixelationState extends State<ShaderPixelation>
    with SingleTickerProviderStateMixin {
  late FragmentShader _shader;

  // 슬라이더 값을 저장할 상태 변수
  double _pixelationValue = 20.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _shader = ShaderRepository().shaders.pixelation;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AnimatedSampler(
            (image, size, canvas) {
              _shader
                ..setFloat(0, size.width)
                ..setFloat(1, size.height)
                ..setFloat(2, _pixelationValue)
                ..setFloat(3, _pixelationValue)
                ..setImageSampler(0, image);
              Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
              canvas.drawRect(rect, Paint()..shader = _shader);
            },
            child: Image.asset(
              'assets/images/me.jpeg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        // 모자이크 강도를 조절하는 슬라이더 위젯
        Slider(
          value: _pixelationValue,
          min: 1.0,
          max: 100.0,
          onChanged: (double value) {
            setState(() {
              _pixelationValue = value;
            });
          },
        ),
      ],
    );
  }
}
