import 'package:flutter/widgets.dart';
import 'dart:async';

class Debounce {
  Debounce({required this.milliseconds});

  final int milliseconds;
  Timer? _timer;

  call(VoidCallback action) {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}

class Throttle {
  Throttle({required this.milliseconds});

  int _lassClickTime = 0;
  final int milliseconds;

  call(VoidCallback action) {
    final currentClickTime = DateTime.now().millisecondsSinceEpoch;
    if (currentClickTime - _lassClickTime > milliseconds) {
      action();
      _lassClickTime = currentClickTime;
    }
  }
}
