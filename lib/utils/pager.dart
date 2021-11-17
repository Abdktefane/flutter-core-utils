import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mobx/mobx.dart';

mixin Pager<T extends StatefulWidget, V> on State<T> {
  late final PagingController<int, V> pagingController;
  late final ReactionDisposer _reaction;

  int get firstPageKey => 0;
  int get invisibleItemsThreshold => 5;
  bool get delayRecationRegist => false;

  @override
  void initState() {
    super.initState();
    pagingController = PagingController<int, V>(
      firstPageKey: firstPageKey,
      invisibleItemsThreshold: invisibleItemsThreshold,
    )..addPageRequestListener(loadData);
    if (!delayRecationRegist) {
      _registReaction();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (delayRecationRegist) {
      _registReaction();
    }
  }

  @override
  void dispose() {
    pagingController.dispose();
    _reaction();
    super.dispose();
  }

  void _registReaction() => _reaction = reaction((_) => paginationState, updatePage);

  void updatePage(PaginationState<V>? state) {
    if (state == null) {
      return;
    }
    pagingController.value = PagingState(
      itemList: state.items,
      nextPageKey: state.nextPage,
      error: state.error,
    );
  }

  PaginationState<V>? get paginationState;

  /// Responsible for fetching data from the source based on [page] then update observerd [paginationState]
  void loadData(int page);

  /// Responsible for update observered [paginationState] with [paginationState.items] = [null]
  void refreshData();
}

class PaginationState<T> extends Equatable {
  const PaginationState({
    this.items,
    this.nextPage,
    this.error,
  });
  final List<T>? items;
  final int? nextPage;
  final dynamic error;

  static PaginationState<T> init<T>() {
    return const PaginationState(
      error: null,
      items: null,
      nextPage: 0,
    );
  }

  PaginationState<T> copyWith({
    List<T>? items,
    int? nextPage,
    dynamic error,
  }) {
    return PaginationState<T>(
      items: items ?? this.items,
      nextPage: nextPage ?? this.nextPage,
      error: error ?? this.error,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [items, nextPage, error];
}
