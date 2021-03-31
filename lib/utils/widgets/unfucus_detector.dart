import 'package:flutter/material.dart';

class FocusDetector extends StatelessWidget {
  const FocusDetector({Key key, @required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragDown: (_) => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
