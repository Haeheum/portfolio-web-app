import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';
import 'package:portfolio/src/util/ticking_builder.dart';

import '../../data/shader_repository.dart';

class ShaderMagic extends StatefulWidget {
  const ShaderMagic({super.key});

  @override
  State<ShaderMagic> createState() => _ShaderMagicState();
}

class _ShaderMagicState extends State<ShaderMagic>
    with SingleTickerProviderStateMixin {
  late FragmentShader _shader;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _shader = ShaderRepository().shaders.magic;
  }

  @override
  Widget build(BuildContext context) {
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
  }
}
