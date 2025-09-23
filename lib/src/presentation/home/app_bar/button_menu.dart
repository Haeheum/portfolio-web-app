import 'package:flutter/material.dart';
import 'package:portfolio/src/presentation/home/page_home.dart';

class ButtonMenu extends StatefulWidget {
  const ButtonMenu({super.key});

  @override
  State<ButtonMenu> createState() => _ButtonMenuState();
}

class _ButtonMenuState extends State<ButtonMenu> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: PageHome.of(context).toggleMenu,
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
          child: const Icon(Icons.menu_rounded),
        ),
      ),
    );
  }
}
