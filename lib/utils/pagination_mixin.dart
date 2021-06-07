import 'package:core_sdk/utils/debouncer.dart';
import 'package:flutter/cupertino.dart';

mixin PaginationMixin {
  late ScrollController scrollController;
  final Debounce debouncer = Debounce(delay: Duration(milliseconds: 600));

  void initPagination() {
    scrollController = ScrollController()..addListener(_handleScrollListner);
  }

  void disposePagination() {
    scrollController.dispose();
  }

  void _handleScrollListner() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent / 2 &&
        !scrollController.position.outOfRange) {
      debouncer.run(onLoadMore);
    }
  }

  void onLoadMore();
}
