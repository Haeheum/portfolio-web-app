import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';
import 'package:portfolio/src/util/ticking_builder.dart';

import '../../config/theme_extension.dart';
import '../../data/shader_repository.dart';

class ShaderRainWindow extends StatefulWidget {
  const ShaderRainWindow({super.key});

  @override
  State<ShaderRainWindow> createState() => _ShaderRainWindowState();
}

class _ShaderRainWindowState extends State<ShaderRainWindow>
    with SingleTickerProviderStateMixin {
  late FragmentShader _shader;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _shader = ShaderRepository().shaders.rainWindow;

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).extension<ExtensionColors>()!.skyColor!,
      child: TickingBuilder(builder: (context, time) {
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
      }),
    );
  }
}
