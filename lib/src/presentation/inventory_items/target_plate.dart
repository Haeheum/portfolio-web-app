import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio/src/config/theme_extension.dart';

class TargetPlate extends StatefulWidget {
  const TargetPlate({super.key});

  @override
  State<TargetPlate> createState() => _TargetPlateState();
}

class _TargetPlateState extends State<TargetPlate> {
  Offset? _mouseOffset;

  bool _hasTouchedEdge = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: _hasTouchedEdge
          ? Theme.of(context).extension<ExtensionColors>()!.warningColor
          : Theme.of(context)
              .extension<ExtensionColors>()!
              .cardBackgroundColor,
      child: MouseRegion(
        onHover: (mouseEvent) {
          setState(() {
            _mouseOffset = mouseEvent.localPosition;
            // debugPrint('$_mouseOffset');
          });
        },
        onExit: (_) {
          setState(() {
            _mouseOffset = null;
          });
        },
        child: CustomPaint(
          painter: TargetPlatePainter(
            mouseOffset: _mouseOffset,
            toggleBackgroundColor: toggleBackgroundColor,
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }

  void toggleBackgroundColor({required bool hasTouchedEdge}) {
    if (_hasTouchedEdge != hasTouchedEdge) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _hasTouchedEdge = hasTouchedEdge;
        });
      });
    }
  }
}

class TargetPlatePainter extends CustomPainter {
  final void Function({required bool hasTouchedEdge}) toggleBackgroundColor;

  Offset? _mouseOffset;

  TargetPlatePainter({
    required this.toggleBackgroundColor,
    Offset? mouseOffset,
  }) : _mouseOffset = mouseOffset;

  @override
  void paint(Canvas canvas, Size size) {
    _mouseOffset ??= Offset(size.width / 2, size.height / 2);

    // 타겟 원 좌표
    final double dx = _mouseOffset!.dx - size.width / 2;
    final double dy = _mouseOffset!.dy - size.height / 2;

    // 마우스 벡터
    Offset targetCircleOffset = Offset(dx, dy);

    // 타겟 원 최종 x,y 벡터 값
    late final double correctedDx;
    late final double correctedDy;

    // 캔버스 중점 좌표
    final double centerX = size.width / 2; // 화면 넓이의 절반
    final double centerY = size.height / 2; // 화면 높이의 절반

    // 큰 원의 반지름 (화면 넓이 또는 높이의 절반의 80%)
    final double bigCircleRadius = min(centerX, centerY) * 0.80;

    // 타겟 원의 반지름 (큰 원의 13%)
    final double targetCircleRadius = bigCircleRadius * 0.13;

    if (targetCircleOffset.distance >= bigCircleRadius - targetCircleRadius) {
      // 타겟 원의 벡터 값이 큰원에 접하거나 외부로 넘어갈 경우 (한계 거리 이상일 경우)
      // 벡터 값 * (한계 거리/현재 거리) 하여 큰 원에 접하는 같은 방향을 가지는 벡터 값으로 보정
      correctedDx = dx *
          (bigCircleRadius - targetCircleRadius) /
          targetCircleOffset.distance;
      correctedDy = dy *
          (bigCircleRadius - targetCircleRadius) /
          targetCircleOffset.distance;
      toggleBackgroundColor(hasTouchedEdge: true);
    } else {
      // 타겟 원이 큰원에 접하지 않거나 내부에 있을 경우 무보정
      correctedDx = dx;
      correctedDy = dy;
      toggleBackgroundColor(hasTouchedEdge: false);
    }

    // 그릴 타겟 원 픽셀 좌표
    double targetCirclePixelX = centerX + correctedDx;
    double targetCirclePixelY = centerY + correctedDy;

    // 큰 원을 그릴 Paint 객체 생성
    Paint bigCirclePaint = Paint()
      ..color = const Color(0xFF24332C)
      ..style = PaintingStyle.fill;

    // 표적 라인 Paint 객체 생성
    Paint aimLinePaint = Paint()
      ..color = const Color(0xFF8FAFAD)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // 타겟 원에 그릴 명암 생성
    final Rect rect = Rect.fromCircle(
      center: Offset(targetCirclePixelX - targetCircleRadius * 0.63,
          targetCirclePixelY - targetCircleRadius * 0.31),
      radius: targetCircleRadius * 1.471,
    );

    // 타겟 원을 그릴 Paint 객체 생성
    Paint targetCirclePaint = Paint()
      ..color = const Color(0xFFE76565)
      ..style = PaintingStyle.fill
      ..shader = const RadialGradient(colors: [
        Color(0xFFE66464),
        Color(0xFFC64D4D),
      ], stops: [
        0.68,
        1.0,
      ]).createShader(rect);

    // 큰 원
    canvas.drawCircle(
        Offset(centerX, centerY), bigCircleRadius, bigCirclePaint);
    // 표적 세로선
    canvas.drawLine(Offset(centerX, centerY - bigCircleRadius),
        Offset(centerX, centerY + bigCircleRadius), aimLinePaint);
    // 표적 가로선
    canvas.drawLine(Offset(centerX - bigCircleRadius, centerY),
        Offset(centerX + bigCircleRadius, centerY), aimLinePaint);
    // 타겟 원
    canvas.drawCircle(Offset(targetCirclePixelX, targetCirclePixelY),
        targetCircleRadius, targetCirclePaint);
  }

  @override
  bool shouldRepaint(TargetPlatePainter oldDelegate) {
    return _mouseOffset != oldDelegate._mouseOffset;
  }
}
