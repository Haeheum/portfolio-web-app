// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `ABC`
  String get abc {
    return Intl.message('ABC', name: 'abc', desc: '', args: []);
  }

  /// `Loading background musics`
  String get messageAudioLoading {
    return Intl.message(
      'Loading background musics',
      name: 'messageAudioLoading',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Skills`
  String get skills {
    return Intl.message('Skills', name: 'skills', desc: '', args: []);
  }

  /// `Inventory`
  String get inventory {
    return Intl.message('Inventory', name: 'inventory', desc: '', args: []);
  }

  /// `Projects`
  String get projects {
    return Intl.message('Projects', name: 'projects', desc: '', args: []);
  }

  /// `Contact`
  String get contact {
    return Intl.message('Contact', name: 'contact', desc: '', args: []);
  }

  /// `Custom widget`
  String get sunMoonSwitchTitle {
    return Intl.message(
      'Custom widget',
      name: 'sunMoonSwitchTitle',
      desc: '',
      args: [],
    );
  }

  /// `Skeleton UI`
  String get shimmerEffectTitle {
    return Intl.message(
      'Skeleton UI',
      name: 'shimmerEffectTitle',
      desc: '',
      args: [],
    );
  }

  /// `Custom paint`
  String get confettiTitle {
    return Intl.message(
      'Custom paint',
      name: 'confettiTitle',
      desc: '',
      args: [],
    );
  }

  /// `Rain`
  String get digitalRainTitle {
    return Intl.message('Rain', name: 'digitalRainTitle', desc: '', args: []);
  }

  /// `Water effect`
  String get shaderWaterTitle {
    return Intl.message(
      'Water effect',
      name: 'shaderWaterTitle',
      desc: '',
      args: [],
    );
  }

  /// `Glitch effect`
  String get shaderGlitchTitle {
    return Intl.message(
      'Glitch effect',
      name: 'shaderGlitchTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pixelation effect`
  String get shaderPixelationTitle {
    return Intl.message(
      'Pixelation effect',
      name: 'shaderPixelationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Flashlight effect`
  String get shaderFlashlightTitle {
    return Intl.message(
      'Flashlight effect',
      name: 'shaderFlashlightTitle',
      desc: '',
      args: [],
    );
  }

  /// `Ripple effect`
  String get shaderRippleTitle {
    return Intl.message(
      'Ripple effect',
      name: 'shaderRippleTitle',
      desc: '',
      args: [],
    );
  }

  /// `Smoke effect`
  String get shaderSmokeTitle {
    return Intl.message(
      'Smoke effect',
      name: 'shaderSmokeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Magic effect`
  String get shaderMagicTitle {
    return Intl.message(
      'Magic effect',
      name: 'shaderMagicTitle',
      desc: '',
      args: [],
    );
  }

  /// `Night Vision effect`
  String get shaderNightVisionTitle {
    return Intl.message(
      'Night Vision effect',
      name: 'shaderNightVisionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Rain Window effect`
  String get shaderRainWindowTitle {
    return Intl.message(
      'Rain Window effect',
      name: 'shaderRainWindowTitle',
      desc: '',
      args: [],
    );
  }

  /// `Card flip`
  String get cardFlipTitle {
    return Intl.message('Card flip', name: 'cardFlipTitle', desc: '', args: []);
  }

  /// `Interactive plate`
  String get interactivePlateTitle {
    return Intl.message(
      'Interactive plate',
      name: 'interactivePlateTitle',
      desc: '',
      args: [],
    );
  }

  /// `Network image loading`
  String get fetchImageTitle {
    return Intl.message(
      'Network image loading',
      name: 'fetchImageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Loading Failed`
  String get fetchImageErrorText {
    return Intl.message(
      'Loading Failed',
      name: 'fetchImageErrorText',
      desc: '',
      args: [],
    );
  }

  /// `Load image`
  String get fetchImage {
    return Intl.message('Load image', name: 'fetchImage', desc: '', args: []);
  }

  /// `Circle collision detection`
  String get circleCollisionTitle {
    return Intl.message(
      'Circle collision detection',
      name: 'circleCollisionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Area inversion effect`
  String get flashEffectTitle {
    return Intl.message(
      'Area inversion effect',
      name: 'flashEffectTitle',
      desc: '',
      args: [],
    );
  }

  /// `Shader mask`
  String get shaderMaskTitle {
    return Intl.message(
      'Shader mask',
      name: 'shaderMaskTitle',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Daegu, South Korea`
  String get addressInfo {
    return Intl.message(
      'Daegu, South Korea',
      name: 'addressInfo',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `Call me!`
  String get contactMe {
    return Intl.message('Call me!', name: 'contactMe', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ko'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
