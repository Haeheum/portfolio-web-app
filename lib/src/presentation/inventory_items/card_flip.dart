import 'dart:math';

import 'package:flutter/material.dart';

class CardFlip extends StatefulWidget {
  const CardFlip({super.key});

  @override
  State<CardFlip> createState() => _CardFlipState();
}

class _CardFlipState extends State<CardFlip> {
  bool _isFront = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TweenAnimationBuilder(
          tween: Tween(begin: 0.0, end: _isFront ? 0.0 : -180.0),
          duration: const Duration(milliseconds: 700),
          builder: (context, value, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateY(value * pi / 180),
              child: child,
            );
          },
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
        Align(
          alignment: Alignment.bottomCenter,
          child: IconButton(
            onPressed: () {
              setState(() {
                _isFront = !_isFront;
              });
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
        )
      ],
    );
  }
}
