import 'package:flutter/material.dart';

import '../../model/app_state_model.dart';

class AppStateScope extends InheritedNotifier<AppStateModel> {
  const AppStateScope({
    super.key,
    super.notifier,
    required super.child,
  });

  static AppStateModel of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AppStateScope>()!
        .notifier!;
  }
}
