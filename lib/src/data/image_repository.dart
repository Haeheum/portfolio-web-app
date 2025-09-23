import 'dart:math';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageRepository {
  static final ImageRepository instance = ImageRepository._();

  ImageRepository._();

  factory ImageRepository() => instance;

  Future<void> preCacheImages(BuildContext context) async {
    for (String fileName in rawImageData) {
      precacheImage(AssetImage('assets/images/$fileName'), context);
    }
  }

  Future fetchImage({required bool willSucceed}) async {
    if (willSucceed) {
      int seed = Random().nextInt(100);

      return FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: 'https://picsum.photos/seed/$seed/200/300');
    } else {
      throw Exception('Failed to load image');
    }
  }
}

const List<String> rawImageData = [
  'bee_sad.webp',
  'flag_america.png',
  'flag_korea.png',
  'folder_colored.png',
  'folder_disabled.png',
  'hero.png',
  'me.jpeg',
  'singer.webp',
];
