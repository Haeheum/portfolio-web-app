import 'package:flutter/material.dart';

import '../../config/theme_extension.dart';

class ViewTerminal extends StatefulWidget {
  final String title;
  final Widget body;

  const ViewTerminal({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  State<ViewTerminal> createState() => _ViewTerminalState();
}

class _ViewTerminalState extends State<ViewTerminal> {
  bool _onHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _onHover = true;
        });
      },
      onExit: (_) {
        setState(() {
          _onHover = false;
        });
      },
      child: Card(
        elevation: _onHover ? 15 : 0,
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: _onHover
                    ? Theme.of(context)
                        .extension<ExtensionColors>()!
                        .terminalAppBarColor
                    : Theme.of(context)
                        .extension<ExtensionColors>()!
                        .terminalUnfocusedAppBarColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              height: 27.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 9),
                      CircleAvatar(
                        backgroundColor: _onHover
                            ? const Color(0xFFF45D55)
                            : Theme.of(context)
                                .extension<ExtensionColors>()!
                                .terminalUnfocusedAppBarTextColor,
                        radius: 6,
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: _onHover
                            ? const Color(0xFFF4B52F)
                            : Theme.of(context)
                                .extension<ExtensionColors>()!
                                .terminalUnfocusedAppBarTextColor,
                        radius: 6,
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: _onHover
                            ? const Color(0xFF29BF40)
                            : Theme.of(context)
                                .extension<ExtensionColors>()!
                                .terminalUnfocusedAppBarTextColor,
                        radius: 6,
                      ),
                      const SizedBox(width: 9),
                    ],
                  ),
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                            _onHover
                                ? 'assets/images/folder_colored.png'
                                : 'assets/images/folder_disabled.png',
                            width: 14,
                            height: 14),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            widget.title,
                            style: const TextStyle().copyWith(
                                color: _onHover
                                    ? Theme.of(context)
                                        .extension<ExtensionColors>()!
                                        .terminalAppBarTextColor
                                    : Theme.of(context)
                                        .extension<ExtensionColors>()!
                                        .terminalUnfocusedAppBarTextColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 70),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 0.5,
            ),
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 6.0),
                  color: Theme.of(context)
                      .extension<ExtensionColors>()!
                      .terminalBackgroundColor,
                  child: widget.body),
            ),
          ],
        ),
      ),
    );
  }
}
