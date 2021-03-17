import 'package:core_sdk/utils/colors.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final bool visibility;
  final double strokeWidth;
  final double size;
  final double padding;
  final Color color;

  ProgressBar({
    this.size = 14.0,
    this.padding = 0.0,
    this.strokeWidth = 1.5,
    this.color = WHITE,
    this.visibility = true,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ),
    );
  }
}
