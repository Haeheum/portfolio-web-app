

class BackgroundMusic {
  final String filename;
  final String artistName;
  final String musicName;

  const BackgroundMusic({required this.filename, this.artistName = 'unknown', this.musicName = 'unknown'});

  String getInfo() => '$artistName - $musicName';
}
