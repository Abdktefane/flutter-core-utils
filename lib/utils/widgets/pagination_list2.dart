import 'package:core_sdk/utils/widgets/focusable_action_detector.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PaginationList2<T> extends StatelessWidget {
  const PaginationList2({
    Key? key,
    required this.pagingController,
    required this.itemBuilder,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
    this.dragStartBehavior = DragStartBehavior.start,
    this.transitionDuration = const Duration(milliseconds: 350),
    this.scrollDirection = Axis.vertical,
    this.clipBehavior = Clip.hardEdge,
    this.animateTransitions = true,
    this.reverse = false,
    this.shrinkWrap = false,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.itemsMargin = 0.0,
    this.scrollController,
    this.primary,
    this.physics,
    this.padding,
    this.cacheExtent,
    this.restorationId,
    this.itemExtent,
    this.newPageErrorIndicatorBuilder,
    this.newPageProgressIndicatorBuilder,
    this.firstPageErrorIndicatorBuilder,
    this.firstPageProgressIndicatorBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.noMoreItemsIndicatorBuilder,
    this.separatorBuilder,
    // shortcuts
    this.forceFocus = false,
    this.autoFocus = true,
    this.enableShortcuts = true,
    this.rebuildOnHover = false,
    this.canChildRequestFocus = false,
    this.onHoverCallback,
    this.onSelect,
    this.customKeys,
    this.selectedDecoratoinBuilder,
  }) : super(key: key);

  final PagingController<int, T> pagingController;
  final Widget Function(T value) itemBuilder;
  final bool animateTransitions;
  final Duration transitionDuration;
  final bool shrinkWrap;
  final double itemsMargin;

  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final ScrollController? scrollController;
  final Axis scrollDirection;
  final bool reverse;
  final bool? primary;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final double? cacheExtent;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;
  final double? itemExtent;
  final Widget? firstPageProgressIndicatorBuilder;
  final Widget? newPageProgressIndicatorBuilder;
  final Widget? firstPageErrorIndicatorBuilder;
  final Widget? newPageErrorIndicatorBuilder;
  final Widget? noItemsFoundIndicatorBuilder;
  final Widget? noMoreItemsIndicatorBuilder;
  final Widget Function(BuildContext, int)? separatorBuilder;

  // shortcuts params
  final bool enableShortcuts;
  final bool forceFocus;
  final bool autoFocus;
  final Map<LogicalKeySet, VoidCallback?>? customKeys;
  final bool canChildRequestFocus;
  final bool rebuildOnHover;
  final ValueChanged<bool>? onHoverCallback;
  final BoxDecoration Function(bool isSelected)? selectedDecoratoinBuilder;
  final void Function(T, int)? onSelect;

  List<T> get itemList => pagingController.itemList ?? [];

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, T>.separated(
      pagingController: pagingController,
      shrinkWrap: shrinkWrap,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior,
      dragStartBehavior: dragStartBehavior,
      itemExtent: itemExtent,
      keyboardDismissBehavior: keyboardDismissBehavior,
      padding: padding,
      physics: physics,
      primary: primary,
      restorationId: restorationId,
      reverse: reverse,
      scrollController: scrollController,
      scrollDirection: scrollDirection,
      separatorBuilder: separatorBuilder ?? (_, __) => SizedBox(height: itemsMargin),
      builderDelegate: PagedChildBuilderDelegate<T>(
        itemBuilder: itemsBuilder,
        animateTransitions: animateTransitions,
        transitionDuration: transitionDuration,
        firstPageProgressIndicatorBuilder:
            firstPageProgressIndicatorBuilder == null ? null : (_) => firstPageProgressIndicatorBuilder!,
        newPageProgressIndicatorBuilder:
            newPageProgressIndicatorBuilder == null ? null : (_) => newPageProgressIndicatorBuilder!,
        firstPageErrorIndicatorBuilder:
            firstPageErrorIndicatorBuilder == null ? null : (_) => firstPageErrorIndicatorBuilder!,
        newPageErrorIndicatorBuilder:
            newPageErrorIndicatorBuilder == null ? null : (_) => newPageErrorIndicatorBuilder!,
        noItemsFoundIndicatorBuilder:
            noItemsFoundIndicatorBuilder == null ? null : (_) => noItemsFoundIndicatorBuilder!,
        noMoreItemsIndicatorBuilder: noMoreItemsIndicatorBuilder == null ? null : (_) => noMoreItemsIndicatorBuilder!,
      ),
    );
  }

  Widget itemsBuilder(BuildContext context, T item, int index) {
    if (!enableShortcuts) {
      return itemBuilder(item);
    }
    return FAD(
      rebuildOnHover: rebuildOnHover,
      forceFocus: index == 0 && forceFocus,
      autoFocus: 0 == index && autoFocus,
      customKeys: enableShortcuts ? customKeys : null,
      onEnterCallback: onSelect != null ? () => onSelect!(item, index) : null,
      onHoverCallback: onHoverCallback,
      onArrowDownCallback: itemList.isNotEmpty && index + 1 < itemList.length
          ? () => Actions.invoke(
                context,
                const DirectionalFocusIntent(TraversalDirection.down, ignoreTextFields: true),
              )
          : null,
      onArrowUpCallback: itemList.isNotEmpty && index - 1 >= 0
          ? () => Actions.invoke(
                context,
                const DirectionalFocusIntent(TraversalDirection.up, ignoreTextFields: true),
              )
          : null,
      child: (isFocused, isHovered) {
        final body = AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: selectedDecoratoinBuilder?.call(isFocused || isHovered),
          child: itemBuilder(item),
        );
        return canChildRequestFocus
            ? body
            : FocusScope(
                canRequestFocus: canChildRequestFocus,
                child: body,
              );
      },
    );
  }
}
