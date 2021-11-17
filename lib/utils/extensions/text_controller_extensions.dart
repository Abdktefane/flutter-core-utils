import 'package:flutter/material.dart';

extension TextEditingControllerExt on TextEditingController? {
  void selectAll() {
    if (this?.text == null || this?.text.isEmpty == true) return;
    this?.selection = TextSelection(baseOffset: 0, extentOffset: this?.text.length ?? 0);
  }
}
