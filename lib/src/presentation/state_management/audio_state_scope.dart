import 'package:flutter/widgets.dart';

class AudioStateScope extends InheritedWidget {
  const AudioStateScope({
    super.key,
    required this.shouldPlay,
    required this.artistName,
    required this.musicName,
    required this.volume,
    required super.child,
  });

  final ValueNotifier<bool> shouldPlay;
  final ValueNotifier<String> artistName;
  final ValueNotifier<String> musicName;
  final ValueNotifier<double> volume;

  static AudioStateScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AudioStateScope>()!;
  }

  @override
  bool updateShouldNotify(AudioStateScope oldWidget) {
    return false;
  }
}
