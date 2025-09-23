import 'dart:math';

import 'package:flutter/material.dart';

class SunMoonSwitch extends StatefulWidget {
  final ValueChanged<bool> onChanged;

  const SunMoonSwitch({
    super.key,
    required this.onChanged,
  });

  @override
  State<SunMoonSwitch> createState() => _SunMoonSwitchState();
}

class _SunMoonSwitchState extends State<SunMoonSwitch>
    with TickerProviderStateMixin {
  bool _isSun = true;

  late final AnimationController _sunController;
  late final AnimationController _moonController;
  late final Animation<double> _sunAnimation;

  @override
  void initState() {
    super.initState();
    _sunController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _moonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )
      ..value = 1.0
      ..addListener(() {
        _sunController.value = 1.0 - _moonController.value;
      });
    _sunAnimation = CurvedAnimation(
      parent: _sunController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _sunController.dispose();
    _moonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 369 / 145,
      child: LayoutBuilder(builder: (context, constraints) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(constraints.maxHeight / 2),
          clipBehavior: Clip.antiAlias,
          child: Material(
            borderRadius: BorderRadius.circular(constraints.maxHeight / 2),
            child: GestureDetector(
              onTap: () async {
                if (_isSun) {
                  _moonController.reverse();
                } else {
                  _moonController.forward();
                }
                setState(() {
                  _isSun = !_isSun;
                });
                widget.onChanged(_isSun);
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) {
                  if (_isSun) {
                    _sunController.repeat(
                      max: 0.20,
                      reverse: true,
                    );
                  } else {
                    _moonController.repeat(
                      max: 0.20,
                      reverse: true,
                    );
                  }
                },
                onExit: (_) {
                  if (_isSun) {
                    _sunController.animateTo(0);
                  } else {
                    _moonController.animateTo(0);
                  }
                },
                child: AnimatedContainer(
                  color: _isSun ? Colors.blue : const Color(0xFF062938),
                  duration: const Duration(milliseconds: 400),
                  child: CustomPaint(
                    painter: SunMoonSwitchPainter(sunAnimation: _sunAnimation),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class SunMoonSwitchPainter extends CustomPainter {
  final Animation<double> _sunAnimation;

  SunMoonSwitchPainter({required Animation<double> sunAnimation})
      : _sunAnimation = sunAnimation,
        super(repaint: sunAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    final sunMoonRadius = size.height * 60 / 145;
    final sunMoonDefaultXPosition = size.height * 0.5;
    final sunMoonOffset = Offset(
      sunMoonDefaultXPosition +
          (size.width - 2 * sunMoonDefaultXPosition) * _sunAnimation.value,
      size.height / 2,
    );

    _drawCloudBehind(canvas, size, _sunAnimation.value);
    _drawStars(canvas, size, _sunAnimation.value);
    _drawRays(canvas, sunMoonOffset, sunMoonRadius);
    _drawCloudFront(canvas, size, _sunAnimation.value);
    _drawSun(canvas, sunMoonOffset, sunMoonRadius, _sunAnimation.value);
    _drawMoon(canvas, sunMoonOffset, sunMoonRadius, _sunAnimation.value);
    _drawShadow(canvas, size);
  }

  void _drawCloudBehind(Canvas canvas, Size size, double animationValue) {
    canvas.save();
    final cloudPaint = Paint()
      ..color = const Color(0xFFA6C5DD)
      ..style = PaintingStyle.fill;

    if (animationValue > 0.2) {
      canvas.translate(0,
          animationValue * animationValue * animationValue * size.height * 2.5);
    }
    canvas.drawCircle(Offset(size.width * 0.125, size.height * 0.925),
        size.height * 8 / 29, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.24, size.height * 0.95),
        size.height * 8 / 29, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.39, size.height * 1.01),
        size.height * 8 / 29, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.52, size.height * 0.85),
        size.height * 8 / 29, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.88),
        size.height * 8 / 29, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.73, size.height * 0.73),
        size.height * 8 / 29, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.89, size.height * 0.59),
        size.height * 8 / 29, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.89, size.height * 0.10),
        size.height * 59 / 145, cloudPaint);
    canvas.restore();
  }

  void _drawStars(Canvas canvas, Size size, double animationValue) {
    canvas.save();
    final starPaint = Paint()
      ..color = const Color(0xfff3f4f5)
      ..style = PaintingStyle.fill;

    canvas.translate(
        0,
        -1 *
            (1 - animationValue) *
            (1 - animationValue) *
            (1 - animationValue) *
            (1 - animationValue) *
            (1 - animationValue) *
            size.height *
            550);

    final stars = [
      [Offset(size.width * 0.505, size.height * 0.44), size.width * 0.013],
      [Offset(size.width * 0.48, size.height * 0.68), size.width * 0.020],
      [Offset(size.width * 0.42, size.height * 0.475), size.width * 0.005],
      [Offset(size.width * 0.345, size.height * 0.66), size.width * 0.010],
      [Offset(size.width * 0.325, size.height * 0.39), size.width * 0.010],
      [Offset(size.width * 0.205, size.height * 0.23), size.width * 0.018],
      [Offset(size.width * 0.215, size.height * 0.55), size.width * 0.004],
      [Offset(size.width * 0.14, size.height * 0.68), size.width * 0.009],
      [Offset(size.width * 0.09, size.height * 0.31), size.width * 0.009],
    ];

    for (final star in stars) {
      final Offset starOffset = star[0] as Offset;
      final double starSize = star[1] as double;

      canvas.drawPath(_getStarPath(starOffset, starSize), starPaint);
    }
    canvas.restore();
  }

  Path _getStarPath(Offset startAt, double starSize) {
    final Path starPath = Path();

    starPath.moveTo(startAt.dx, startAt.dy);
    starPath.arcToPoint(startAt + Offset(starSize, starSize),
        radius: Radius.circular(starSize));
    starPath.arcToPoint(startAt + Offset(2 * starSize, 0),
        radius: Radius.circular(starSize));
    starPath.arcToPoint(startAt + Offset(starSize, -starSize),
        radius: Radius.circular(starSize));
    starPath.arcToPoint(startAt, radius: Radius.circular(starSize));
    starPath.close();
    return starPath;
  }

  void _drawRays(Canvas canvas, Offset offset, double sunMoonRadius) {
    final rayPaint = Paint()..color = Colors.white.withValues(alpha: 0.1);
    canvas.drawCircle(offset, sunMoonRadius * 51 / 30, rayPaint);
    canvas.drawCircle(offset, sunMoonRadius * 12 / 5, rayPaint);
    canvas.drawCircle(offset, sunMoonRadius * 19 / 6, rayPaint);
  }

  void _drawCloudFront(Canvas canvas, Size size, double animationValue) {
    canvas.save();
    final cloudPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    if (animationValue > 0.2) {
      canvas.translate(0,
          animationValue * animationValue * animationValue * size.height * 2.0);
    }
    canvas.drawCircle(Offset(size.width * 0.15, size.height),
        size.height * 8 / 29, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 1.13),
        size.height * 8 / 29, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.41, size.height * 1.11),
        size.height * 8 / 29, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.565, size.height * 0.99),
        size.height * 8 / 29, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.68, size.height * 1.1),
        size.height * 8 / 29, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.785, size.height * 0.99),
        size.height * 8 / 29, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.92, size.height * 0.78),
        size.height * 8 / 29, cloudPaint);
    canvas.drawCircle(Offset(size.width * 0.99, size.height * 0.26),
        size.height * 53 / 145, cloudPaint);
    canvas.restore();
  }

  void _drawSun(Canvas canvas, Offset offset, double sunMoonRadius,
      double animationValue) {
    if (animationValue <= 0.7) {
      final sunShadowPaint = Paint()
        ..color =
            const Color(0xFFF1E4E4).withValues(alpha: 1.0 - animationValue)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(offset, sunMoonRadius, sunShadowPaint);

      final sunPaint = Paint()
        ..color = const Color(0xFFE8C32E)
            .withValues(alpha: sqrt(1.0 - animationValue))
        ..maskFilter = MaskFilter.blur(BlurStyle.inner, sunMoonRadius * 0.12);
      canvas.drawCircle(offset, sunMoonRadius, sunPaint);
    }
  }

  void _drawMoon(Canvas canvas, Offset offset, double sunMoonRadius,
      double animationValue) {
    if (animationValue > 0.3) {
      final moonShadowPaint = Paint()
        ..color = Colors.black.withValues(alpha: 0.25 * animationValue)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(offset, sunMoonRadius, moonShadowPaint);

      final moonPaint = Paint()
        ..color = const Color(0xFFC2C7CE)
            .withValues(alpha: sqrt(sqrt(animationValue)))
        ..maskFilter = MaskFilter.blur(BlurStyle.inner, sunMoonRadius * 0.1);
      canvas.drawCircle(offset, sunMoonRadius, moonPaint);

      if (animationValue > 0.5) {
        final craterPaint = Paint()
          ..color = const Color(0xFF98A2B4).withValues(
              alpha: animationValue * animationValue * animationValue)
          ..maskFilter = MaskFilter.blur(BlurStyle.inner, sunMoonRadius * 0.03);

        final craterShadowPaint = Paint()
          ..color = Colors.black.withValues(
              alpha: 0.5 * animationValue * animationValue * animationValue)
          ..style = PaintingStyle.fill;

        final craters = [
          [
            offset + Offset(-sunMoonRadius * 0.27, sunMoonRadius * 0.15),
            sunMoonRadius * 0.44
          ],
          [
            offset + Offset(sunMoonRadius * 0.55, sunMoonRadius * 0.16),
            sunMoonRadius * 0.20
          ],
          [
            offset + Offset(-sunMoonRadius * 0.025, -sunMoonRadius * 0.55),
            sunMoonRadius * 0.15
          ],
        ];

        for (final crater in craters) {
          final craterOffset = crater[0] as Offset;
          final craterSize = crater[1] as double;

          canvas.drawCircle(craterOffset, craterSize, craterShadowPaint);
          canvas.drawCircle(craterOffset, craterSize, craterPaint);
        }
      }
    }
  }

  void _drawShadow(Canvas canvas, Size size) {
    final canvasShadowPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.height * 3 / 145
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, size.height * 5 / 145);

    final canvasPath = Path()
      ..moveTo(size.height / 2, 0)
      ..lineTo(size.width - size.height / 2, 0)
      ..arcToPoint(Offset(size.width, size.height / 2),
          radius: Radius.circular(size.height / 2))
      ..lineTo(size.width, size.height / 2)
      ..arcToPoint(Offset(size.width - size.height / 2, size.height),
          radius: Radius.circular(size.height / 2))
      ..lineTo(size.width - size.height / 2, size.height)
      ..lineTo(size.height / 2, size.height)
      ..arcToPoint(Offset(0, size.height / 2),
          radius: Radius.circular(size.height / 2))
      ..lineTo(0, size.height / 2)
      ..arcToPoint(Offset(size.height / 2, 0),
          radius: Radius.circular(size.height / 2))
      ..close();

    canvas.drawPath(canvasPath, canvasShadowPaint);
  }

  @override
  bool shouldRepaint(SunMoonSwitchPainter oldDelegate) {
    return false;
  }
}
