import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../config/theme_extension.dart';
import '../../model/vector.dart';

class DigitalRain extends StatefulWidget {
  const DigitalRain({
    super.key,
  });

  @override
  State<DigitalRain> createState() => _RainingTextsState();
}

class _RainingTextsState extends State<DigitalRain>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: CustomPaint(
        painter: RainingTextsPainter(
            animation: _controller,
            skyColor: Theme.of(context).extension<ExtensionColors>()!.skyColor!,
            rainColor: Theme.of(context).extension<ExtensionColors>()!.rainColor!,
            backgroundColor:
            Theme.of(context).extension<ExtensionColors>()!.backgroundColor!),
        willChange: true,
        child: const SizedBox.expand(),
      ),
    );
  }
}

class RainingTextsPainter extends CustomPainter {
  final Color _skyColor;
  final Color _rainColor;
  final Color _backgroundColor;

  late Rect _canvasRectangle;
  final _skyPaint = Paint();
  late final LinearGradient _skyGradient;

  final int _rainCount = 50;
  late List<_SingleRainDrop> _rain;
  Size? _size;
  DateTime _lastTime = DateTime.now();

  RainingTextsPainter(
      {required Listenable animation,
        required Color skyColor,
        required Color rainColor,
        required Color backgroundColor})
      : _skyColor = skyColor,
        _rainColor = rainColor,
        _backgroundColor = backgroundColor,
        super(repaint: animation) {
    _skyGradient = LinearGradient(
      colors: [_skyColor, _backgroundColor],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (_size == null) {
      _canvasRectangle = Rect.fromLTWH(
          0, 0, size.width, size.height);
      _skyPaint.shader = _skyGradient.createShader(_canvasRectangle);

      _rain = List.generate(_rainCount, (i) {
        return _SingleRainDrop(
          rainColor: _rainColor,
          bounds: size,
        );
      });
    }

    final didResize = _size != null && _size != size;
    final now = DateTime.now();
    final dt = now.difference(_lastTime);

    if (didResize) {
      // New background
      _canvasRectangle = Rect.fromLTWH(
          0, 0, size.width, size.height);
      _skyPaint.shader = _skyGradient.createShader(_canvasRectangle);

      // Add rainDrops
      if (_rainCount > _rain.length) {
        int difference = _rainCount - _rain.length;

        List<_SingleRainDrop> additionalRain = List.generate(difference, (i) {
          return _SingleRainDrop(
            rainColor: _rainColor,
            bounds: size,
          );
        });

        _rain.addAll(additionalRain);
      }
    }
    // Draw background
    canvas.drawRect(_canvasRectangle, _skyPaint);

    List<int> removeIndex = [];
    for (int i = 0; i < _rain.length; i++) {
      if (didResize) {
        bool shouldRemove = _rain[i].updateBounds(size, _rainCount, _rain);
        if (shouldRemove) {
          removeIndex.add(i);
          continue;
        }
      }
      bool shouldRemove =
      _rain[i].update(size, dt.inMilliseconds / 1000, _rainCount, _rain);
      if (shouldRemove) {
        removeIndex.add(i);
        continue;
      }
      _rain[i].draw(canvas);
    }
    removeIndex.sort((b, a) => a.compareTo(b));
    for (int index in removeIndex) {
      _rain.removeAt(index);
    }

    _size = size;
    _lastTime = now;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _SingleRainDrop {
  static final Random _random = Random();

  Size _bounds;

  late final Vector _position = Vector(
    _random.nextDouble() * _bounds.width,
    _random.nextDouble() * _bounds.height -
        (_bounds.height + kToolbarHeight + kToolbarHeight),
  );
  final double _length = 5 + _random.nextDouble() * 20;

  bool _useReducedLength = false;
  late double _reducedLength;

  late final double _ySpeed = sqrt(_length) * 70 + _random.nextDouble() * 70;

  final _rainPaint = Paint();

  _SingleRainDrop({
    required Color rainColor,
    required Size bounds,
  }) : _bounds = bounds {
    _rainPaint.color = rainColor;
  }

  void draw(Canvas canvas) {
    Rect rainRect = Rect.fromPoints(
        Offset(_position.x - _length / 50, _position.y),
        _useReducedLength
            ? Offset(_position.x + _length / 50, _position.y + _reducedLength)
            : Offset(_position.x + _length / 50, _position.y + _length));
    canvas.drawRect(rainRect, _rainPaint);
  }

  bool update(
      Size newBounds, double dt, int rainCount, List<_SingleRainDrop> rain) {
    if (_position.y + _length > _bounds.height) {
      _useReducedLength = true;
      _reducedLength = _bounds.height - _position.y;
    }

    if (_position.y > _bounds.height) {
      if (rainCount < rain.length) {
        return true;
      }
      _useReducedLength = false;
      _position.x = _random.nextDouble() * _bounds.width;
      _position.y = -_length - kToolbarHeight;
    }
    _position.y += _ySpeed * dt;
    return false;
  }

  bool updateBounds(Size newBounds, int rainCount, List<_SingleRainDrop> rain) {
    if (!newBounds.contains(Offset(_position.x, _position.y))) {
      if (!newBounds.contains(
          Offset(_position.x, _position.y + _length + kToolbarHeight))) {
        if (rainCount < rain.length) {
          return true;
        } else {
          _position.x = _random.nextDouble() * newBounds.width;
          _position.y = (-_length - kToolbarHeight);
        }
      }
    }
    _bounds = newBounds;
    return false;
  }
}
