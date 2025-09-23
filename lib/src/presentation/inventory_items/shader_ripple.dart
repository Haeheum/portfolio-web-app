import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

import 'package:portfolio/src/util/ticking_builder.dart';
import 'package:portfolio/src/data/shader_repository.dart';

class ShaderRipple extends StatefulWidget {
  const ShaderRipple({super.key});

  @override
  State<ShaderRipple> createState() => _ShaderRippleState();
}

class _ShaderRippleState extends State<ShaderRipple> {
  late FragmentShader _shader;

  // 클릭 위치와 시간 상태 변수
  Offset _clickPosition = const Offset(-1.0, -1.0); // 초기값은 화면 밖
  double _clickTime = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _shader = ShaderRepository().shaders.ripple;
  }

  void _handleTapDown(TapDownDetails details, Size size, double currentTime) {
    _clickPosition = Offset(
      details.localPosition.dx / size.width,
      details.localPosition.dy / size.height,
    );
    _clickTime = currentTime;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        return TickingBuilder(builder: (context, time) {
          return GestureDetector(
            onTapDown: (details) => _handleTapDown(details, size, time),
            child: AnimatedSampler(
                  (image, samplerSize, canvas) {
                _shader
                  ..setFloat(0, samplerSize.width)
                  ..setFloat(1, samplerSize.height)
                  ..setFloat(2, time)
                  ..setFloat(3, _clickPosition.dx)
                  ..setFloat(4, _clickPosition.dy)
                  ..setFloat(5, _clickTime)
                  ..setImageSampler(0, image);

                Rect rect = Rect.fromLTWH(0, 0, samplerSize.width, samplerSize.height);
                canvas.drawRect(rect, Paint()..shader = _shader);
              },
              child: Image.asset('assets/images/me.jpeg', fit: BoxFit.cover),
            ),
          );
        });
      },
    );
  }
}