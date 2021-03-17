import 'package:flutter/material.dart';

import '../colors.dart';

class BottomSheetHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 38.0,
        height: 5.0,
        margin: EdgeInsets.symmetric(vertical: 15.0),
        decoration: BoxDecoration(
          color: LIGHT_GREY,
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }
}
