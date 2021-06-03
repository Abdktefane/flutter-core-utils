import 'package:core_sdk/utils/extensions/list.dart';
import 'package:core_sdk/utils/widgets/staggered_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class StaggredPaginationList<T> extends StatelessWidget {
  const StaggredPaginationList({
    Key? key,
    required this.dataList,
    required this.cardBuilder,
    required this.canLoadMore,
    required this.scrollController,
    required this.emptyWidget,
    this.padding = 0,
    this.shrinkWrap = true,
    this.physics = const BouncingScrollPhysics(),
    this.loadingWidget = const Padding(padding: EdgeInsets.all(8.0), child: Center(child: CircularProgressIndicator())),
    this.staggeredAnimations,
    this.useLimiter = true,
    this.duration = const Duration(milliseconds: 500),
    this.cardAnimationBuilder,
  }) : super(key: key);

  final ScrollPhysics physics;
  final List<T> dataList;
  final bool shrinkWrap;
  final Widget Function(T data) cardBuilder;
  final bool canLoadMore;
  final ScrollController scrollController;
  final Widget loadingWidget;
  final Widget? emptyWidget;
  final double padding;
  final List<StaggeredType>? staggeredAnimations;
  final bool useLimiter;
  final Duration duration;
  final Widget Function(Widget child)? cardAnimationBuilder;

  @override
  Widget build(BuildContext context) {
    if (dataList.isNullOrEmpty) return emptyWidget ?? SizedBox();
    final body = ListView.builder(
      shrinkWrap: shrinkWrap,
      controller: scrollController,
      physics: physics,
      itemCount: dataList.length + 1,
      itemBuilder: (_, index) => AnimationConfiguration.staggeredList(
        position: index,
        duration: duration,
        child: index != dataList.length
            ? Padding(
                padding: EdgeInsets.only(bottom: padding),
                // child: cardAnimationBuilder?.call(dataList[index]) ?? cardBuilder(dataList[index]),
                child: cardAnimationBuilder?.call(cardBuilder(dataList[index])) ??
                    staggeredAnimations?.toWidget(
                      context,
                      child: cardBuilder(dataList[index]),
                    ),
              )
            : canLoadMore
                ? loadingWidget
                : SizedBox(),
      ),
    );
    return useLimiter ? AnimationLimiter(child: body) : body;
  }
}
