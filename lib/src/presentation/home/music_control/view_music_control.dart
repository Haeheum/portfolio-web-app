import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../config/theme_extension.dart';
import '../../../data/audio_repository.dart';
import '../../audio/widget_audio_controller.dart';
import '../../state_management/audio_state_scope.dart';
import 'button_animated_play_pause.dart';

class ViewMusicControl extends StatefulWidget {
  const ViewMusicControl({super.key});

  @override
  State<ViewMusicControl> createState() => _ViewMusicControlState();
}

class _ViewMusicControlState extends State<ViewMusicControl> {
  late Widget _animatedWidget;
  ScrollNotificationObserverState? _scrollNotificationObserver;
  bool _isShowing = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animatedWidget = AudioRepository().preCacheProgress.value != 100
        ? _loadingView()
        : _controlView();

    _scrollNotificationObserver?.removeListener(_handleScrollNotification);
    _scrollNotificationObserver = ScrollNotificationObserver.maybeOf(context);
    _scrollNotificationObserver?.addListener(_handleScrollNotification);
  }

  @override
  void dispose() {
    if (_scrollNotificationObserver != null) {
      _scrollNotificationObserver!.removeListener(_handleScrollNotification);
      _scrollNotificationObserver = null;
    }
    super.dispose();
  }

  void _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification &&
        defaultScrollNotificationPredicate(notification)) {
      switch (notification.scrollDelta) {
        case null:
          break;
        case < 0:
          if (!_isShowing) {
            setState(() {
              _isShowing = true;
            });
          }
        case > 0:
          if (_isShowing) {
            setState(() {
              _isShowing = false;
            });
          }
        default:
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      left: 0,
      top: _isShowing ? kToolbarHeight : 0,
      right: 0,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
      child: AnimatedOpacity(
        opacity: _isShowing ? 1.0 : 0.0,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 500),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          height: 120,
          child: AnimatedAlign(
            alignment: MediaQuery.sizeOf(context).width < 1200
                ? Alignment.center
                : Alignment.centerRight,
            curve: Curves.fastEaseInToSlowEaseOut,
            duration: const Duration(milliseconds: 500),
            child: Container(
              height: 96.0,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .extension<ExtensionColors>()!
                    .cardBackgroundColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              constraints: const BoxConstraints(maxWidth: 450),
              child: AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: _animatedWidget,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadingView() {
    return Row(
      key: const ValueKey<int>(0),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ValueListenableBuilder(
            valueListenable: AudioRepository().preCacheProgress,
            builder: (_, progress, __) {
              if (progress == 100) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _animatedWidget = _controlView();
                  });
                });
              }
              return CircularProgressIndicator(
                value: progress / 100,
              );
            }),
        const SizedBox(width: 12.0),
        Text(
          S.of(context).messageAudioLoading,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Theme.of(context).extension<ExtensionColors>()!.textColor),
        ),
      ],
    );
  }

  Widget _controlView() {
    return Row(
      key: const ValueKey<int>(1),
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(width: 4.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.asset(
            'assets/images/singer.webp',
            height: 80,
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: FittedBox(
            alignment: Alignment.centerLeft,
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder(
                  valueListenable: AudioStateScope.of(context).musicName,
                  builder: (_, musicName, ___) {
                    return Text(
                      musicName,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context)
                              .extension<ExtensionColors>()!
                              .textColor),
                    );
                  },
                ),
                ValueListenableBuilder(
                    valueListenable: AudioStateScope.of(context).artistName,
                    builder: (_, artistName, ___) {
                      return Text(
                        artistName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .extension<ExtensionColors>()!
                                .textColor),
                      );
                    }),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        IconButton(
          onPressed: WidgetAudioController.of(context).previousBgm,
          icon: const Icon(Icons.skip_previous),
        ),
        const ButtonAnimatedPlayPause(),
        IconButton(
          onPressed: () {
            WidgetAudioController.of(context).nextBgm(null);
          },
          icon: const Icon(Icons.skip_next),
        ),
        const SizedBox(width: 4.0),
      ],
    );
  }
}
