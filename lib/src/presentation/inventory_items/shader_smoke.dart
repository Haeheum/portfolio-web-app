import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

import 'package:portfolio/src/util/ticking_builder.dart';
import 'package:portfolio/src/data/shader_repository.dart';

class ShaderSmoke extends StatefulWidget {
  const ShaderSmoke({super.key});

  @override
  State<ShaderSmoke> createState() => _ShaderSmokeState();
}

class _ShaderSmokeState extends State<ShaderSmoke> {
  late FragmentShader _shader;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _shader = ShaderRepository().shaders.smoke;
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return TickingBuilder(builder: (context, time) {
          return AnimatedSampler(
            (image, size, canvas) {
              _shader
                ..setFloat(0, size.width)
                ..setFloat(1, size.height)
                ..setFloat(2, time)
                ..setImageSampler(0, image);

              Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
              canvas.drawRect(rect, Paint()..shader = _shader);
            },
            child: Image.asset('assets/images/me.jpeg'),
          );
        });
      },
    );
  }
}
