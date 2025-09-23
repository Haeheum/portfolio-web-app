import 'package:flutter/material.dart';
import 'package:portfolio/src/config/theme_extension.dart';

import '../../../generated/l10n.dart';
import '../../model/menu_item.dart';

class PageMenu extends StatefulWidget {
  final Function(double) animateTo;
  final VoidCallback toggleMenu;

  const PageMenu({
    super.key,
    required this.animateTo,
    required this.toggleMenu,
  });

  @override
  State<PageMenu> createState() => _PageMenuState();
}

class _PageMenuState extends State<PageMenu> {
  final List<MenuItem> _menuItems = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _menuItems
      ..clear()
      ..add(
        MenuItem(
          title: S.of(context).home,
          icon: Icons.home_rounded,
          offset: 0.0,
        ),
      )
      ..add(
        MenuItem(
          title: S.of(context).inventory,
          icon: Icons.build,
          offset: MediaQuery.sizeOf(context).height * 2,
        ),
      )
      ..add(
        MenuItem(
          title: S.of(context).contact,
          icon: Icons.mail_rounded,
          offset: 9999.0,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.toggleMenu,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        color: Theme.of(context).extension<ExtensionColors>()!.backgroundColor2,
        child: Material(
          color:
              Theme.of(context).extension<ExtensionColors>()!.backgroundColor2,
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: kToolbarHeight),
                const Spacer(),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 400.0 - kToolbarHeight,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ..._menuItems.map((menuItem) {
                        return _buildWidgetMenuItem(
                          menuItem: menuItem,
                          maxHeight: (constraints.maxHeight - kToolbarHeight) / _menuItems.length,
                        );
                      }),
                    ],
                  ),
                ),
                const Spacer(flex: 2),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildWidgetMenuItem(
      {required MenuItem menuItem, required double maxHeight}) {
    return Flexible(
      child: InkWell(
        onTap: () => widget.animateTo(menuItem.offset),
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(
            maxHeight: maxHeight,
          ),
          child: Row(
            children: [
              const SizedBox(width: 8.0),
              Icon(menuItem.icon),
              const SizedBox(width: 16.0),
              Text(
                menuItem.title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context)
                        .extension<ExtensionColors>()!
                        .textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
