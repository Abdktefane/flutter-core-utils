import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

enum StaggeredType { FadeInAnimation, SlideAnimation, ScaleAnimation, FlipAnimation }

extension StaggeredTypeExtension on StaggeredType {
  Widget toWidget(BuildContext context, Widget child) {
    switch (this) {
      case StaggeredType.FadeInAnimation:
        return FadeInAnimation(child: child);
      case StaggeredType.SlideAnimation:
        return SlideAnimation(
          horizontalOffset: MediaQuery.of(context).size.width / 2,
          child: child,
        );
      case StaggeredType.ScaleAnimation:
        return ScaleAnimation(child: child);
      case StaggeredType.FlipAnimation:
        return FlipAnimation(child: child);
    }
  }
}

extension ListStaggeredTypeExtension on List<StaggeredType> {
  Widget toWidget(BuildContext context, {Widget? child}) {
    if (this.length == 1) {
      return this.first.toWidget(context, child!);
    }
    return this.first.toWidget(context, this.sublist(1).toWidget(context, child: child));
  }
}

class StaggeredColumn extends StatelessWidget {
  const StaggeredColumn({
    Key? key,
    this.duration = const Duration(milliseconds: 500),
    this.useLimiter = true,
    this.childAnimationBuilder,
    required this.staggeredChilds,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;
  final bool useLimiter;
  final Duration duration;
  final Widget Function(Widget)? childAnimationBuilder;
  final List<StaggeredType> staggeredChilds;

  @override
  Widget build(BuildContext context) {
    final body = Column(
      children: AnimationConfiguration.toStaggeredList(
        duration: duration,
        childAnimationBuilder: childAnimationBuilder ?? (widget) => staggeredChilds.toWidget(context, child: widget),
        children: children,
      ),
    );
    return useLimiter ? AnimationLimiter(child: body) : body;
  }
}
