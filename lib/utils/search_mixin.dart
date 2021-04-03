import 'package:core_sdk/utils/debouncer.dart';
import 'package:flutter/cupertino.dart';

mixin SearchMixin {
  final Debounce _debouncer = Debounce();
  final FocusNode searchFocusNode = FocusNode();
  TextEditingController searchController;
  String lastQuery = '';

  void initSearch() {
    searchController = TextEditingController()..addListener(_handleTyping);
  }

  void disposeSearch() {
    searchController.dispose();
    searchFocusNode.dispose();
  }

  void _handleTyping() {
    _debouncer.run(() {
      if (lastQuery == searchController?.text ?? '') return;
      lastQuery = searchController?.text;
      onSearch(searchController?.text ?? '');
    });
  }

  void onSearch(String qurey);
}
