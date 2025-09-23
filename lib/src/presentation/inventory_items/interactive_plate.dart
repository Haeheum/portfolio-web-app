import 'dart:math';

import 'package:flutter/material.dart';

class InteractivePlate extends StatefulWidget {
  const InteractivePlate({super.key});

  @override
  State<InteractivePlate> createState() => _InteractivePlateState();
}

class _InteractivePlateState extends State<InteractivePlate> {
  static const double _defaultScale = 1.0;
  static const double _targetScale = 1.05;

  double _x = 0;
  double _y = 0;
  double _currentScale = _defaultScale;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: LayoutBuilder(builder: (context, constraints) {
        return MouseRegion(
          onEnter: (_) {
            setState(() {
              _currentScale = _targetScale;
            });
          },
          onHover: (event) {
            setState(() {
              _x = (event.localPosition.dx - (constraints.maxWidth / 2)) /
                  (constraints.maxWidth / 2);
              _y = (event.localPosition.dy - constraints.maxHeight / 2) /
                  (constraints.maxHeight / 2);
            });
          },
          onExit: (_) {
            setState(() {
              _x = 0;
              _y = 0;
              _currentScale = _defaultScale;
            });
          },
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: _currentScale,
            child: Transform(
              transform: Matrix4.identity()..setEntry(3, 2, 0.08),
              alignment: Alignment.center,
              child: AnimatedContainer(
                transformAlignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateY(-_x / 4 * pi / 180)
                  ..rotateX(_y / 4 * pi / 180),
                duration: const Duration(milliseconds: 200),
                child: Card(
                  elevation: 15,
                  clipBehavior: Clip.antiAlias,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      'assets/images/me.jpeg',
                      fit: BoxFit.cover,
                    ),
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
