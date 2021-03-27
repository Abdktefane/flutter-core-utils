import 'package:core_sdk/utils/extensions/list.dart';
import 'package:flutter/material.dart';

class PaginationList<T> extends StatelessWidget {
  const PaginationList({
    Key key,
    @required this.dataList,
    @required this.cardBuilder,
    @required this.canLoadMore,
    @required this.scrollController,
    @required this.emptyWidget,
    this.shrinkWrap = true,
    this.physics = const BouncingScrollPhysics(),
    this.loadingWidget = const Padding(padding: EdgeInsets.all(8.0), child: Center(child: CircularProgressIndicator())),
  }) : super(key: key);

  final ScrollPhysics physics;
  final List<T> dataList;
  final bool shrinkWrap;
  final Widget Function(T data) cardBuilder;
  final bool canLoadMore;
  final ScrollController scrollController;
  final Widget loadingWidget;
  final Widget emptyWidget;

  @override
  Widget build(BuildContext context) {
    if (dataList.isNullOrEmpty) return emptyWidget ?? SizedBox();
    return ListView.builder(
      shrinkWrap: true,
      controller: scrollController,
      physics: physics,
      itemCount: dataList.length + 1,
      itemBuilder: (_, index) => index != dataList.length
          ? cardBuilder(dataList[index])
          : canLoadMore
              ? loadingWidget
              : SizedBox(),
    );
  }
}
