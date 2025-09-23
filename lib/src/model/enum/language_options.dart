import 'package:flutter/material.dart';

enum LanguageOptions {
  korean('ko', '한글', AssetImage('assets/images/flag_korea.png')),
  english('en', 'English', AssetImage('assets/images/flag_america.png'));

  const LanguageOptions(this.code, this.label, this.image);

  final String code;
  final String label;
  final AssetImage image;
}
