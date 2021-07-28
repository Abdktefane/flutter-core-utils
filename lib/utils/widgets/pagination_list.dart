import 'package:core_sdk/utils/extensions/list.dart';
import 'package:core_sdk/utils/widgets/focusable_action_detector.dart';
import 'package:flutter/material.dart';

class PaginationList<T> extends StatelessWidget {
  const PaginationList({
    Key? key,
    required this.dataList,
    required this.cardBuilder,
    required this.canLoadMore,
    required this.scrollController,
    required this.emptyWidget,
    this.enableShortcuts = true,
    this.padding = 0,
    this.shrinkWrap = true,
    this.forceFocus = false,
    this.autoFocus = true,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
    this.physics = const BouncingScrollPhysics(),
    this.loadingWidget = const Padding(padding: EdgeInsets.all(8.0), child: Center(child: CircularProgressIndicator())),
    this.selectedDecoratoinBuilder,
    this.onSelect,
    this.customKeys,
  }) : super(key: key);

  final ScrollPhysics physics;
  final List<T> dataList;
  final bool shrinkWrap;
  final Widget Function(T data) cardBuilder;
  final bool canLoadMore;
  final ScrollController scrollController;
  final Widget loadingWidget;
  final Widget? emptyWidget;
  final double padding;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final BoxDecoration Function(bool isSelected)? selectedDecoratoinBuilder;
  final void Function(T, int)? onSelect;
  final bool enableShortcuts;
  final bool forceFocus;
  final bool autoFocus;
  final Map<LogicalKeySet, VoidCallback?>? customKeys;

  @override
  Widget build(BuildContext context) {
    if (dataList.isNullOrEmpty) {
      return emptyWidget ?? const SizedBox();
    }
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      controller: scrollController,
      physics: physics,
      itemCount: dataList.length + 1,
      keyboardDismissBehavior: keyboardDismissBehavior,
      addAutomaticKeepAlives: true,
      itemBuilder: (_, index) => index != dataList.length
          ? Padding(
              padding: EdgeInsets.only(bottom: padding),
              child: selectedDecoratoinBuilder != null
                  ? FAD(
                      forceFocus: index == 0 && forceFocus,
                      autoFocus: 0 == index && autoFocus,
                      customKeys: enableShortcuts ? customKeys : null,
                      onEnterCallback: enableShortcuts ? () => onSelect?.call(dataList[index], index) : null,
                      onArrowDownCallback: enableShortcuts
                          ? dataList.isNotEmpty && index + 1 < dataList.length
                              ? () => Actions.invoke(
                                    context,
                                    const DirectionalFocusIntent(TraversalDirection.down, ignoreTextFields: true),
                                  )
                              : null
                          : null,
                      onArrowUpCallback: enableShortcuts
                          ? dataList.isNotEmpty && index - 1 >= 0
                              ? () => Actions.invoke(
                                    context,
                                    const DirectionalFocusIntent(TraversalDirection.up, ignoreTextFields: true),
                                  )
                              : null
                          : null,
                      child: (isFocused, isHovered) => FocusScope(
                        canRequestFocus: false,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          decoration: selectedDecoratoinBuilder?.call(isFocused || isHovered),
                          child: cardBuilder(dataList[index]),
                        ),
                      ),
                    )
                  : cardBuilder(dataList[index]),
            )
          : canLoadMore
              ? loadingWidget
              : const SizedBox(),
    );
  }
}
