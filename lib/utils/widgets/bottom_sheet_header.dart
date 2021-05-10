import 'package:flutter/material.dart';

import '../colors.dart';

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({Key? key, this.color = LIGHT_GREY}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 38.0,
        height: 5.0,
        margin: EdgeInsets.symmetric(vertical: 15.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }
}
