import 'package:flutter/cupertino.dart';

mixin PaginationMixin {
  ScrollController scrollController;

  void initPagination() {
    scrollController = ScrollController()..addListener(_handleScrollListner);
  }

  void disposePagination() {
    scrollController.dispose();
  }

  void _handleScrollListner() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) {
      onLoadMore();
    }
  }

  void onLoadMore();
}
