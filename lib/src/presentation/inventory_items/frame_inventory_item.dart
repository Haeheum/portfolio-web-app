import 'package:flutter/material.dart';

import 'view_terminal.dart';

class FrameInventoryItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Widget child;

  const FrameInventoryItem({
    super.key,
    required this.title,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ViewTerminal(
      title: title,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: child,
      ),
    );
  }
}
