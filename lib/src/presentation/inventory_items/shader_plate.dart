import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class ShaderPlate extends StatelessWidget {
  const ShaderPlate({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 1,
        child: Center(
          child: FutureBuilder<ui.Image>(
            future: _prepareImage(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return ui.ImageShader(snapshot.data!, ui.TileMode.mirror,
                        ui.TileMode.mirror, Matrix4.diagonal3Values(0.5, 0.5, 0.5).storage);
                  },
                  blendMode: ui.BlendMode.srcATop,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                          '${S.of(context).abc}\n${S.of(context).abc}',
                          style: const TextStyle(
                            fontSize: 300,fontWeight: ui.FontWeight.w900,
                          )),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Future<ui.Image> _prepareImage() async {
    final completer = Completer<ui.Image>();
    const imageProvider = AssetImage('assets/images/me.jpeg');
    final imageStream = imageProvider.resolve(ImageConfiguration.empty);
    imageStream.addListener(ImageStreamListener((ImageInfo image, bool sync) {
      completer.complete(image.image);
    }));
    return completer.future;
  }
}
