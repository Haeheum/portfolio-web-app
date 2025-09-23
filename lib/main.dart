import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_browser.dart';

import 'generated/l10n.dart';
import 'src/config/theme.dart';
import 'src/data/shader_repository.dart';
import 'src/model/app_state_model.dart';
import 'src/presentation/audio/widget_audio_controller.dart';
import 'src/presentation/home/page_home.dart';
import 'src/presentation/state_management/app_state_scope.dart';

Future<void> main() async {
  await ShaderRepository().preLoadShaders();
  await findSystemLocale();
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  late final AppStateModel _appState;

  @override
  void initState() {
    super.initState();
    _appState = AppStateModel(
      appLocale: _getLocaleFromLocaleInfo(Intl.systemLocale),
      themeMode: ThemeMode.system,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WidgetAudioController(
      child: AppStateScope(
        notifier: _appState,
        child: Builder(builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: AppStateScope.of(context).appLocale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            home: const PageHome(),
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppStateScope.of(context).themeMode,
          );
        }),
      ),
    );
  }

  Locale _getLocaleFromLocaleInfo(String localeInfo) {
    List<String> parts = localeInfo.split('_');
    // parts[0] => languageCode, parts[1] => countryCode
    if (parts.length == 2) {
      return Locale(parts[0], parts[1]);
    } else {
      return Locale(parts[0]);
    }
  }
}
