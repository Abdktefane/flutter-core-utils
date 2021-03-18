import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'CrashReportingTree.dart';
import 'Logger.dart';

@Singleton(as: Logger)
class LoggerImpl extends Logger {
  LoggerImpl() {
    final LogTree tree = kReleaseMode ? CrashReportingTree() : DebugTree();
    Fimber.plantTree(tree);
  }
}
