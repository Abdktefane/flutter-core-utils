import 'package:flutter/cupertino.dart';

mixin PaginationMixin {
  late ScrollController scrollController;
  late double percent;
  int lastNumberOfPages = 0;

  void initPagination({double percent = 0.5}) {
    scrollController = ScrollController()..addListener(_handleScrollListner);
    this.percent = percent;
  }

  void disposePagination() {
    scrollController.dispose();
  }

  void _handleScrollListner() {
    final double max = scrollController.position.maxScrollExtent;
    final double viewport = scrollController.position.viewportDimension;
    final double before = scrollController.position.extentBefore;
    final int numberOfPages = max ~/ viewport;
    if (before > (max / 2) && !scrollController.position.outOfRange && lastNumberOfPages != numberOfPages) {
      lastNumberOfPages = numberOfPages;
      onLoadMore();
    }
  }

  // void _handleScrollListner() {
  //   final double max = scrollController.position.maxScrollExtent;
  //   final double viewport = scrollController.position.viewportDimension;
  //   final double before = scrollController.position.extentBefore;
  //   final int numberOfPages = max ~/ viewport;
  //   final int currentPage = before ~/ viewport;
  //   if (currentPage / numberOfPages >= percent &&
  //       !scrollController.position.outOfRange &&
  //       lastNumberOfPages != numberOfPages) {
  //     lastNumberOfPages = numberOfPages;
  //     onLoadMore();
  //   }
  // }

  void onLoadMore();
}
