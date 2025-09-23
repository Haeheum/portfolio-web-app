import 'dart:async';
import 'dart:collection';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/src/util/debounce_manager.dart';

import '../../data/audio_repository.dart';
import '../../util/global_constants.dart';
import '../../model/background_music.dart';
import '../state_management/audio_state_scope.dart';

class WidgetAudioController extends StatefulWidget {
  const WidgetAudioController({super.key, required this.child});

  final Widget child;

  static WidgetAudioControllerState of(BuildContext context) {
    return context.findAncestorStateOfType<WidgetAudioControllerState>()!;
  }

  @override
  State<WidgetAudioController> createState() => WidgetAudioControllerState();
}

class WidgetAudioControllerState extends State<WidgetAudioController> {
  late final AppLifecycleListener _appLifecycleListener;
  late final AudioPlayer _bgmPlayer;
  late Queue<BackgroundMusic> _bgmPlaylist;

  final ValueNotifier<bool> shouldPlay = ValueNotifier(false);
  final ValueNotifier<String> artistName = ValueNotifier('');
  final ValueNotifier<String> musicName = ValueNotifier('');
  final ValueNotifier<double> volume = ValueNotifier(kDefaultVolume);

  bool _isRunning = false;

  void _syncAudioInfo() {
    artistName.value = _bgmPlaylist.first.artistName;
    musicName.value = _bgmPlaylist.first.musicName;
  }

  void _initializeAudio() {

    _bgmPlayer = AudioPlayer()..setVolume(kDefaultVolume);
    _bgmPlayer.onPlayerComplete.listen(nextBgm);

    _bgmPlaylist =
        Queue.of(List<BackgroundMusic>.of(backgroundMusics)..shuffle());

    _syncAudioInfo();
  }

  void _attachLifecycleChangeHandler() {
    _appLifecycleListener = AppLifecycleListener(
      onResume: () {
        if (shouldPlay.value) {
          _bgmPlayer.resume();
        }
      },
      onInactive: () {
        if (_bgmPlayer.state == PlayerState.playing) {
          _bgmPlayer.pause();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeAudio();
    _attachLifecycleChangeHandler();
  }

  @override
  void dispose() {
    _appLifecycleListener.dispose();
    _bgmPlayer.dispose();
    super.dispose();
  }

  Future<void> _playFirstBgm(String filename) async {
    if (!_isRunning) {
      _isRunning = true;
      shouldPlay.value = true;
      await _bgmPlayer
          .play(AssetSource('sounds/bgm/$filename'))
          .whenComplete(() {
        _isRunning = false;
        if (_bgmPlaylist.first.filename != filename) {
          _playFirstBgm(_bgmPlaylist.first.filename);
        }
      });
    }
  }

  void nextBgm(void _) {
    _bgmPlayer.stop();

    _bgmPlaylist.addLast(_bgmPlaylist.removeFirst());
    _syncAudioInfo();

    if (shouldPlay.value) {
      DebounceManager.run(
        action: () {
          _playFirstBgm(_bgmPlaylist.first.filename);
        },
      );
    }
  }

  void previousBgm() async {
    Duration? currentPosition = await _bgmPlayer.getCurrentPosition();
    _bgmPlayer.stop();

    // 현재 곡 재생 위치가 2초 이하 일때 이전 곡을 큐의 첫번째 항목으로 가져옴.
    if (currentPosition == null ||
        currentPosition.compareTo(const Duration(seconds: 2)) <= 0) {
      _bgmPlaylist.addFirst(_bgmPlaylist.removeLast());
      _syncAudioInfo();
    }

    if (shouldPlay.value) {
      DebounceManager.run(
        action: () {
          _playFirstBgm(_bgmPlaylist.first.filename);
        },
      );
    }
  }

  void pauseBgm() {
    if (_bgmPlayer.state == PlayerState.playing) {
      _bgmPlayer.pause();
    }
    shouldPlay.value = false;
  }

  Future<void> playBgm() async {
    switch (_bgmPlayer.state) {
      case PlayerState.paused:
        await _bgmPlayer.resume();
        shouldPlay.value = true;
      case PlayerState.stopped:
      case PlayerState.completed:
        _playFirstBgm(_bgmPlaylist.first.filename);
      case PlayerState.playing:
      case PlayerState.disposed:
        AudioPlayerException(_bgmPlayer, cause: 'Wrong state to play Bgm.');
    }
  }

  Future<void> setBgmVolume(double newVolume) async {
    volume.value = newVolume;
    if (!_isRunning) {
      _isRunning = true;
      await _bgmPlayer.setVolume(newVolume).whenComplete(() {
        _isRunning = false;
        if (volume.value != newVolume) {
          setBgmVolume(volume.value);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AudioStateScope(
      shouldPlay: shouldPlay,
      artistName: artistName,
      musicName: musicName,
      volume: volume,
      child: widget.child,
    );
  }
}
