import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../config/theme_extension.dart';

class PageContact extends StatelessWidget {
  const PageContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Theme.of(context).extension<ExtensionColors>()!.backgroundColor,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: kToolbarHeight),
          Flexible(
            child: Center(
              child: Text(
                S.of(context).contact,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Theme.of(context)
                        .extension<ExtensionColors>()!
                        .textColor),
              ),
            ),
          ),
          Card(
            color: Theme.of(context)
                .extension<ExtensionColors>()!
                .cardBackgroundColor,
            child: ListTile(
              leading: const Icon(Icons.account_box_rounded),
              title: Text(S.of(context).address),
              subtitle: Text(S.of(context).addressInfo),
            ),
          ),
          Card(
            color: Theme.of(context)
                .extension<ExtensionColors>()!
                .cardBackgroundColor,
            child: ListTile(
              leading: const Icon(Icons.mail_rounded),
              title: Text(S.of(context).email),
              subtitle: const SelectableText('hammizzang@naver.com'),
            ),
          ),
          Card(
            color: Theme.of(context)
                .extension<ExtensionColors>()!
                .cardBackgroundColor,
            child: ListTile(
              leading: const Icon(Icons.phone_iphone_rounded),
              title: Text(S.of(context).phone),
              subtitle: const SelectableText('+82 10 4083 7389'),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
