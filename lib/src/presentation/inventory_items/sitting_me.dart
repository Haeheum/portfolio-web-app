import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../config/theme_extension.dart';

class SittingMe extends StatefulWidget {
  const SittingMe({super.key});

  @override
  State<SittingMe> createState() => _SittingMeState();
}

class _SittingMeState extends State<SittingMe> {
  Offset _mouseOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: false,
      onHover: (event) {
        setState(() {
          _mouseOffset = event.localPosition;
        });
      },
      child: FutureBuilder<ui.Image>(
        future: _prepareImage(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomPaint(
                painter: SittingMePainter(
                  mouseOffset: _mouseOffset,
                  heroImage: snapshot.data!,
                ),
                child: SizedBox.expand(
                  child: Align(
                    alignment: const Alignment(0.4, 0.6),
                    child: Card(
                      color: Theme.of(context)
                          .extension<ExtensionColors>()!
                          .backgroundColor2,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          S.of(context).contactMe,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .extension<ExtensionColors>()!
                                      .textColor),
                        ),
                      ),
                    ),
                  ),
                ));
          } else {
            return const SizedBox.expand();
          }
        },
      ),
    );
  }

  Future<ui.Image> _prepareImage() async {
    final completer = Completer<ui.Image>();
    const imageProvider = AssetImage('assets/images/hero.png');
    final imageStream = imageProvider.resolve(ImageConfiguration.empty);
    imageStream.addListener(ImageStreamListener((ImageInfo image, bool sync) {
      completer.complete(image.image);
    }));
    return completer.future;
  }
}

class SittingMePainter extends CustomPainter {
  final Offset _mouseOffset;
  final ui.Image _heroImage;

  SittingMePainter({required Offset mouseOffset, required ui.Image heroImage})
      : _mouseOffset = mouseOffset,
        _heroImage = heroImage {
    imageSize = Size(_heroImage.width.toDouble(), _heroImage.height.toDouble());
    srcRect = Offset.zero & imageSize;
  }

  final Paint _heroPaint = Paint();
  final Paint _eyePaint = Paint();
  Size? _canvasSize;
  late final Size imageSize;
  late final Rect srcRect;
  late Rect dstRect;

  @override
  void paint(Canvas canvas, Size size) {
    final heroHeight = size.height / 3;
    final heroWidth = heroHeight * 28 / 40;
    final heroOffsetX = size.width / 2 - heroWidth;
    final heroOffsetY = size.height - heroHeight;
    if (_canvasSize == null || _canvasSize != size) {
      dstRect = Offset(heroOffsetX, heroOffsetY) & Size(heroWidth, heroHeight);
    }

    final heroDefaultLeftEyeX = heroOffsetX + heroWidth * 0.345;
    final heroDefaultLeftEyeY = heroOffsetY + heroHeight * 0.217;
    final leftEyeMaxDistance = heroWidth / 40;
    final leftEyeDistance = sqrt((_mouseOffset.dx - heroDefaultLeftEyeX) *
            (_mouseOffset.dx - heroDefaultLeftEyeX) +
        (_mouseOffset.dy - heroDefaultLeftEyeY) *
            (_mouseOffset.dy - heroDefaultLeftEyeY));
    final double heroLeftEyeX;
    final double heroLeftEyeY;

    if (_mouseOffset == Offset.zero) {
      heroLeftEyeX = heroDefaultLeftEyeX;
      heroLeftEyeY = heroDefaultLeftEyeY;
    } else {
      if (leftEyeDistance < leftEyeMaxDistance) {
        heroLeftEyeX = _mouseOffset.dx;
        heroLeftEyeY = _mouseOffset.dy;
      } else {
        heroLeftEyeX = (leftEyeMaxDistance * _mouseOffset.dx +
                (leftEyeDistance - leftEyeMaxDistance) * heroDefaultLeftEyeX) /
            leftEyeDistance;
        heroLeftEyeY = (leftEyeMaxDistance * _mouseOffset.dy +
                (leftEyeDistance - leftEyeMaxDistance) * heroDefaultLeftEyeY) /
            leftEyeDistance;
      }
    }

    final heroDefaultRightEyeX = heroOffsetX + heroWidth * 0.435;
    final heroDefaultRightEyeY = heroOffsetY + heroHeight * 0.213;
    final rightEyeMaxDistance = heroWidth / 45;
    final rightEyeDistance = sqrt((_mouseOffset.dx - heroDefaultRightEyeX) *
            (_mouseOffset.dx - heroDefaultRightEyeX) +
        (_mouseOffset.dy - heroDefaultRightEyeY) *
            (_mouseOffset.dy - heroDefaultRightEyeY));
    final double heroRightEyeX;
    final double heroRightEyeY;

    if (_mouseOffset == Offset.zero) {
      heroRightEyeX = heroDefaultRightEyeX;
      heroRightEyeY = heroDefaultRightEyeY;
    } else {
      if (leftEyeDistance < leftEyeMaxDistance) {
        heroRightEyeX = _mouseOffset.dx;
        heroRightEyeY = _mouseOffset.dy;
      } else {
        heroRightEyeX = (rightEyeMaxDistance * _mouseOffset.dx +
                (rightEyeDistance - rightEyeMaxDistance) *
                    heroDefaultRightEyeX) /
            rightEyeDistance;
        heroRightEyeY = (rightEyeMaxDistance * _mouseOffset.dy +
                (rightEyeDistance - rightEyeMaxDistance) *
                    heroDefaultRightEyeY) /
            rightEyeDistance;
      }
    }

    canvas.drawImageRect(_heroImage, srcRect, dstRect, _heroPaint);
    _canvasSize = size;

    canvas.drawCircle(
        Offset(heroLeftEyeX, heroLeftEyeY), heroWidth / 88, _eyePaint);

    canvas.drawCircle(
        Offset(heroRightEyeX, heroRightEyeY), heroWidth / 88, _eyePaint);
  }

  @override
  bool shouldRepaint(SittingMePainter oldDelegate) {
    return _mouseOffset != oldDelegate._mouseOffset;
  }
}
