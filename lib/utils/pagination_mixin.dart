import 'package:flutter/cupertino.dart';

mixin PaginationMixin {
  late ScrollController scrollController;
  late double percent;
  // final processingSet = <int>{};
  int lastNumberOfPages = 0;

  void initPagination({double percent = 0.5}) {
    scrollController = ScrollController()..addListener(_handleScrollListner);
    this.percent = percent;
  }

  void disposePagination() {
    scrollController.dispose();
  }

  void _handleScrollListner() {
    // if (scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) {
    //   debouncer.run(onLoadMore);
    // }
    final double max = scrollController.position.maxScrollExtent;
    final double viewport = scrollController.position.viewportDimension;
    final double before = scrollController.position.extentBefore;
    final int numberOfPages = max ~/ viewport;
    final int currentPage = before ~/ viewport;
    if (currentPage / numberOfPages >= percent &&
            !scrollController.position.outOfRange &&
            lastNumberOfPages != numberOfPages //&&
        // !processingSet.contains(currentPage)
        ) {
      lastNumberOfPages = numberOfPages;
      onLoadMore();
    }
  }

  void onLoadMore();
}
