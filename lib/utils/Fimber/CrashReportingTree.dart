import 'package:fimber/fimber.dart';

class CrashReportingTree extends LogTree {
  //Only Log Warnings and Exceptions
  static const List<String> defaultLevels = ["W", "E"];
  final List<String> logLevels;

  @override
  List<String> getLevels() => logLevels;

  CrashReportingTree({this.logLevels = defaultLevels});

  @override
  void log(String level, String message,
      {String tag, dynamic ex, StackTrace stacktrace}) {
    // ignore: todo
    // TODO add crashlytics here
    /* final crashlytics = Crashlytics.instance;
    crashlytics.log(message);

    if (ex != null) {
      crashlytics.recordError(ex, stacktrace);
    } */
  }
}
