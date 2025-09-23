import 'dart:math';

import 'package:flutter/material.dart';

import '../../../util/global_constants.dart';
import '../../audio/widget_audio_controller.dart';
import '../../state_management/audio_state_scope.dart';

class ButtonAudioVolumeControl extends StatefulWidget {
  const ButtonAudioVolumeControl({super.key});

  @override
  State<ButtonAudioVolumeControl> createState() =>
      _AudioVolumeControllerButtonState();
}

class _AudioVolumeControllerButtonState
    extends State<ButtonAudioVolumeControl> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Align(
        alignment: Alignment.centerLeft,
        child: MouseRegion(
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
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: _isHover ? Theme.of(context).hoverColor : null,
                borderRadius: BorderRadius.circular(20.0),
              ),
              width: _isHover ? min(constraints.maxWidth, 400.0) : 40.0,
              height: 40.0,
              duration: const Duration(milliseconds: 200),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (AudioStateScope.of(context).volume.value == 0) {
                        WidgetAudioController.of(context)
                            .setBgmVolume(kDefaultVolume);
                      } else {
                        WidgetAudioController.of(context).setBgmVolume(0.0);
                      }
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        alignment: Alignment.center,
                        width: 40.0,
                        height: 40.0,
                        child: ValueListenableBuilder(
                            valueListenable: AudioStateScope.of(context).volume,
                            builder: (context, volume, _) {
                              return switch (volume) {
                                0.0 => const Icon(Icons.volume_mute_rounded),
                                >= 0.0 && < 0.5 =>
                                  const Icon(Icons.volume_down_rounded),
                                >= 0.5 => const Icon(Icons.volume_up_rounded),
                                _ =>
                                  throw RangeError('Volume cannot be negative'),
                              };
                            }),
                      ),
                    ),
                  ),
                  if (_isHover)
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: AudioStateScope.of(context).volume,
                        builder: (context, volume, _) {
                          return Slider(
                            value: volume,
                            onChanged: (newVolume) {
                              WidgetAudioController.of(context)
                                  .setBgmVolume(newVolume);
                            },
                          );
                        },
                      ),
                    ),
                ],
              )),
        ),
      );
    });
  }
}
