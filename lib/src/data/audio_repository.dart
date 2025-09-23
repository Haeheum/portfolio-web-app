import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

import '../model/background_music.dart';

class AudioRepository {
  static final AudioRepository instance = AudioRepository._();

  AudioRepository._();

  factory AudioRepository() => instance;

  ValueNotifier<double> preCacheProgress = ValueNotifier(0.0);

  Future<void> preCacheAudios() async {
    if(preCacheProgress.value == 100){
      return;
    }
    List<String> musicFilePaths = backgroundMusics
        .map((music) => 'sounds/bgm/${music.filename}')
        .toList();

    for (String path in musicFilePaths) {
      AudioCache.instance.load(path).then((_) {
        preCacheProgress.value += 100 / musicFilePaths.length;
      });
    }
  }
}

const Set<BackgroundMusic> backgroundMusics = {
  BackgroundMusic(
    filename: 'bgm1.m4a',
    artistName: '별은',
    musicName: '다시 시작된 꿈처럼',
  ),
  BackgroundMusic(
    filename: 'bgm2.m4a',
    artistName: '어쿠레인',
    musicName: '내게도 봄이 올까요 (Feat. 은비 (별은))',
  ),
  BackgroundMusic(
    filename: 'bgm3.m4a',
    artistName: '별은',
    musicName: '생일 축하해 (With. 정유빈)',
  ),
};
