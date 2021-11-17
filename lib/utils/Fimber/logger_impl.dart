import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';

import 'CrashReportingTree.dart';
import 'Logger.dart';

class LoggerImpl extends Logger {
  LoggerImpl() {
    final LogTree tree = kReleaseMode ? CrashReportingTree() : DebugTree();
    Fimber.plantTree(tree);
  }
}
