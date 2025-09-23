import 'package:flutter/material.dart';

import '../../config/theme_extension.dart';

class ScrollIndicator extends StatefulWidget {
  const ScrollIndicator({super.key});

  @override
  State<ScrollIndicator> createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<ScrollIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      lowerBound: 0,
      upperBound: 20,
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(0, -_controller.value),
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context)
              .extension<ExtensionColors>()!
              .cardBackgroundColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: const Icon(Icons.keyboard_double_arrow_down_rounded),
      ),
    );
  }
}
