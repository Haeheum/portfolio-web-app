import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../config/theme_extension.dart';
import '../../data/image_repository.dart';

class FetchImage extends StatefulWidget {
  const FetchImage({super.key});

  @override
  State<FetchImage> createState() => _FetchImageState();
}

class _FetchImageState extends State<FetchImage> {
  bool _willSucceed = false;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: _loadImage(willSucceed: _willSucceed),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return SizedBox(
                width: 200,
                height: 300,
                child: AnimatedSwitcher(
                    duration: const Duration(seconds: 1),
                    child: switch (snapshot.connectionState) {
                      ConnectionState.none ||
                      ConnectionState.waiting =>
                        const CircularProgressIndicator(),
                      ConnectionState.active ||
                      ConnectionState.done when snapshot.hasData =>
                        Center(
                          child: snapshot.data,
                        ),
                      _ => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/bee_sad.webp'),
                            Text(
                              S.of(context).fetchImageErrorText,
                              style: Theme.of(context)
                                  .textTheme.titleLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .extension<ExtensionColors>()!
                                          .textColor),
                            ),
                          ],
                        ),
                    }),
              );
            },
          ),
          const SizedBox(width: 4),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StatefulBuilder(builder: (context, setState) {
                return Switch(
                    value: _willSucceed,
                    onChanged: (willSucceed) {
                      setState(() {
                        _willSucceed = willSucceed;
                      });
                    });
              }),
              const SizedBox(height: 4),
              TextButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text(S.of(context).fetchImage),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future _loadImage({required bool willSucceed}) async {
    return await ImageRepository().fetchImage(willSucceed: _willSucceed);
  }
}
