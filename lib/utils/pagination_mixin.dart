import 'package:flutter/cupertino.dart';

mixin PaginationMixin {
  late ScrollController scrollController;
  late double percent;
  int lastNumberOfPages = 0;

  void initPagination({double percent = 0.7}) {
    scrollController = ScrollController()..addListener(_handleScrollListner);
    this.percent = percent;
  }

  void disposePagination() {
    scrollController.dispose();
  }

  void _handleScrollListner() {
    scrollController.position.pixels;

    final double max = scrollController.position.maxScrollExtent;
    final double viewport = scrollController.position.viewportDimension / 2;
    final double before = scrollController.position.extentBefore;
    final int numberOfPages = (max / viewport).round();
    if (before > (max * percent) && !scrollController.position.outOfRange && lastNumberOfPages != numberOfPages) {
      lastNumberOfPages = numberOfPages;
      onLoadMore();
    }
  }

  void onLoadMore();
}
