import 'package:flutter/material.dart';
import 'package:portfolio/src/presentation/state_management/app_state_scope.dart';

class ButtonThemeToggle extends StatefulWidget {
  const ButtonThemeToggle({super.key});

  @override
  State<ButtonThemeToggle> createState() => _ButtonThemeToggleState();
}

class _ButtonThemeToggleState extends State<ButtonThemeToggle> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: AppStateScope.of(context).toggleThemeMode,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          setState(() {
            _isHover = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isHover = false;
          });
        },
        child: AnimatedContainer(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _isHover ? Theme.of(context).hoverColor : null,
            borderRadius: BorderRadius.circular(20.0),
          ),
          width: 40.0,
          height: 40.0,
          duration: const Duration(milliseconds: 200),
          child: Icon(switch (Theme.of(context).brightness) {
            Brightness.light => Icons.nightlight_round,
            Brightness.dark => Icons.wb_sunny_rounded
          }),
        ),
      ),
    );
  }
}
