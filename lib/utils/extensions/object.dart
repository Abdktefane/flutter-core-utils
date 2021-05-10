import 'package:flutter/material.dart';

extension ObjectExtension<T> on Object {
  T apply(VoidCallback block) {
    block();
    return this as T;
  }

  R run<R>(R Function() block) {
    return block();
  }
}
