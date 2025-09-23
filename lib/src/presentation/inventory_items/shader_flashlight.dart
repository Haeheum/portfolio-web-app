import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';
import 'package:portfolio/src/util/ticking_builder.dart'; // 이 경로는 프로젝트에 맞게 조정

import '../../data/shader_repository.dart'; // FragmentProgram을 위해 import

class ShaderFlashlight extends StatefulWidget {
  const ShaderFlashlight({super.key});

  @override
  State<ShaderFlashlight> createState() => _ShaderFlashlightState();
}

class _ShaderFlashlightState extends State<ShaderFlashlight>
    with SingleTickerProviderStateMixin {
  late FragmentShader _shader;
  Offset _normalizedMousePosition = Offset(-1.0, -1.0); // 초기값은 화면 밖

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _shader = ShaderRepository().shaders.flashlight;
  }

  void _onHover(PointerHoverEvent event) {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    _normalizedMousePosition = Offset(
      event.localPosition.dx / size.width,
      event.localPosition.dy / size.height,
    );
  }

  void _onExit(PointerExitEvent event) {
    _normalizedMousePosition = Offset(-1.0, -1.0);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _onHover,
      onExit: _onExit,
      child: Container(
        color: Colors.black, // 배경은 어둡게 하여 효과를 강조
        child: TickingBuilder(builder: (context, time) {
          return AnimatedSampler(
            (image, size, canvas) {
              _shader
                ..setFloat(0, size.width) // uResolution.x
                ..setFloat(1, size.height) // uResolution.y
                ..setFloat(2, time) // uTime
                ..setFloat(3, _normalizedMousePosition.dx) // uMouse.x
                ..setFloat(4, _normalizedMousePosition.dy) // uMouse.y
                ..setImageSampler(0, image); // uTexture (이미지 샘플러는 항상 0번 인덱스)

              Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
              canvas.drawRect(rect, Paint()..shader = _shader);
            },
            child: Image.asset('assets/images/me.jpeg'),
          );
        }),
      ),
    );
  }
}
