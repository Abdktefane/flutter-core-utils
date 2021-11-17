import 'package:fimber/fimber.dart';

abstract class Logger {
  void v(String message, {dynamic ex, StackTrace? stacktrace}) {
    _log('V', message, ex: ex, stacktrace: stacktrace);
  }

  /// Logs DEBUG level [message]
  /// with optional exception and stacktrace
  void d(String message, {dynamic ex, StackTrace? stacktrace}) {
    _log('D', message, ex: ex, stacktrace: stacktrace);
  }

  /// Logs INFO level [message]
  /// with optional exception and stacktrace
  void i(String message, {dynamic ex, StackTrace? stacktrace}) {
    _log('I', message, ex: ex, stacktrace: stacktrace);
  }

  /// Logs WARNING level [message]
  /// with optional exception and stacktrace
  void w(String message, {dynamic ex, StackTrace? stacktrace}) {
    _log('W', message, ex: ex, stacktrace: stacktrace);
  }

  /// Logs ERROR level [message]
  /// with optional exception and stacktrace
  void e(String message, {dynamic ex, StackTrace? stacktrace}) {
    _log('E', message, ex: ex, stacktrace: stacktrace);
  }

  /// Logs [message] with [tag] and [level]
  /// with optional exception and [stacktrace]
  void _log(String level, String message, {dynamic ex, StackTrace? stacktrace}) {
    Fimber.log(level, message, ex: ex, stacktrace: stacktrace);
  }
}
