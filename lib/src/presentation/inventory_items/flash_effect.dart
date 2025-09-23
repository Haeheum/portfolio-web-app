import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class FlashEffect extends StatefulWidget {
  const FlashEffect({super.key});

  @override
  State<FlashEffect> createState() => _FlashEffectState();
}

class _FlashEffectState extends State<FlashEffect> {
  Offset _mouseOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mouseOffset = event.localPosition;
        });
      },
      onExit: (_) {
        _mouseOffset = Offset.zero;
      },
      child: FutureBuilder<ui.Image>(
          future: _prepareImage(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CustomPaint(
                painter: FlashEffectPainter(
                    mouseOffset: _mouseOffset, backgroundImage: snapshot.data!),
                child: const SizedBox.expand(),
              );
            } else {
              return const SizedBox.expand();
            }
          }),
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

class FlashEffectPainter extends CustomPainter {
  final Offset _mouseOffset;
  final ui.Image _backgroundImage;
  late final Size _backgroundImageSize;
  final Paint _backgroundPaint;
  final Paint _inversionPaint;
  late final Rect _srcRect;
  late Rect _dstRect;

  FlashEffectPainter({required Offset mouseOffset, required backgroundImage})
      : _mouseOffset = mouseOffset,
        _backgroundImage = backgroundImage,
        _backgroundPaint = Paint(),
        _inversionPaint = Paint()
          ..blendMode = BlendMode.difference
          ..color = Colors.white {
    _backgroundImageSize = Size(
        _backgroundImage.width.toDouble(), _backgroundImage.height.toDouble());

    _srcRect = Offset.zero & _backgroundImageSize;
  }

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    _dstRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.height * 3 / 4,
      height: size.height,
    );
    canvas.drawImageRect(
        _backgroundImage, _srcRect, _dstRect, _backgroundPaint);
    if (_mouseOffset == Offset.zero) {
      canvas.drawCircle(
          Offset(size.width / 2, size.height / 2), 50, _inversionPaint);
    } else {
      canvas.drawCircle(_mouseOffset, 50, _inversionPaint);
    }
  }

  @override
  bool shouldRepaint(FlashEffectPainter oldDelegate) {
    return oldDelegate._mouseOffset != _mouseOffset;
  }
}
