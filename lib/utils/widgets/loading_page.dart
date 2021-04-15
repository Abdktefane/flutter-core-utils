import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    Key key,
    @required this.isLoading,
    @required this.child,
    this.loadingWidget = const Center(child: CircularProgressIndicator()),
    this.barrierColor = const Color(0xFFc7c7c7),
    this.animationDuration = const Duration(milliseconds: 400),
  }) : super(key: key);

  final Widget child;

  final Widget loadingWidget;

  final bool isLoading;

  final Color barrierColor;

  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AbsorbPointer(
          absorbing: isLoading,
          child: child,
        ),
        Positioned.fill(
          child: AnimatedSwitcher(
            duration: animationDuration,
            child: isLoading
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(color: barrierColor.withOpacity(0.3)),
                    child: loadingWidget,
                  )
                : SizedBox(width: 0, height: 0),
          ),
        ),
      ],
    );
  }
}
