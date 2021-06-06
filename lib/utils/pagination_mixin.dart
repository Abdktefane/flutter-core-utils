import 'package:flutter/cupertino.dart';

mixin PaginationMixin {
  late ScrollController scrollController;

  void initPagination() {
    scrollController = ScrollController()..addListener(_handleScrollListner);
  }

  void disposePagination() {
    scrollController.dispose();
  }

  void _handleScrollListner() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent / 2 &&
        !scrollController.position.outOfRange) {
      onLoadMore();
    }
  }

  void onLoadMore();
}
