import 'package:flutter/material.dart';

import '../../audio/widget_audio_controller.dart';
import '../../state_management/audio_state_scope.dart';

class ButtonAnimatedPlayPause extends StatefulWidget {
  const ButtonAnimatedPlayPause({super.key});

  @override
  State<ButtonAnimatedPlayPause> createState() =>
      _ButtonAnimatedPlayPauseState();
}

class _ButtonAnimatedPlayPauseState extends State<ButtonAnimatedPlayPause>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (AudioStateScope.of(context).shouldPlay.value) {
      _animationController.animateTo(1.0, duration: const Duration(seconds: 0));
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.play_pause, progress: _animationController),
      onPressed: () {
        if (AudioStateScope.of(context).shouldPlay.value) {
          _animationController.reverse();
          WidgetAudioController.of(context).pauseBgm();
        } else {
          _animationController.forward();
          WidgetAudioController.of(context).playBgm();
        }
      },
    );
  }
}
