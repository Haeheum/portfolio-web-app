import 'dart:async';

import 'package:flutter/foundation.dart';

class DebounceManager {
  static Timer? _timer;

  static void run({
    required VoidCallback action,
    duration = const Duration(milliseconds: 200),
  }) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(duration, action);
  }
}
