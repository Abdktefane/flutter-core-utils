import 'dart:async';

class Debounce {
  final Duration delay;
  Timer? _timer;

  Debounce({this.delay = const Duration(milliseconds: 500)});

  run(Function action) {
    _timer?.cancel();
    _timer = Timer(delay, action as void Function());
  }
}
