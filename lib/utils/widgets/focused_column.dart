import 'package:core_sdk/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';
import 'package:collection/collection.dart';

import 'focusable_action_detector.dart';

class FocusedColumn<T> extends StatelessWidget {
  const FocusedColumn({
    Key? key,
    required this.children,
    this.autoFocus = true,
    this.ignoreTextFields = true,
    this.selectOnHover = true,
    this.forceFocus = false,
    this.focusMode = true,
    this.enableShortcuts = true,
    this.onEnterCallback,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalDirection = VerticalDirection.down,
    this.textDirection,
    this.textBaseline,
    this.selectedDecoratoinBuilder,
    this.customKeys,
    this.dataList,
    this.padding = 0,
  }) : super(key: key);

  final bool autoFocus;
  final List<Widget> children;
  final bool ignoreTextFields;
  final ValueChanged<T?>? onEnterCallback;
  final bool selectOnHover;
  final bool forceFocus;
  final bool focusMode;
  final double padding;
  final List<T>? dataList;

  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final BoxDecoration Function(bool isSelected)? selectedDecoratoinBuilder;
  final Map<LogicalKeySet, ValueChanged<T?>?>? customKeys;
  final bool enableShortcuts;

  BoxDecoration Function(bool isSelected) get decorationBuilder =>
      selectedDecoratoinBuilder ??
      (isSelected) => BoxDecoration(
          color: isSelected ? const Color.fromRGBO(220, 220, 220, 0.6) : Colors.transparent,
          border: Border(
            top: const BorderSide(color: Color.fromRGBO(220, 220, 220, 0.6)),
            bottom: const BorderSide(color: Color.fromRGBO(220, 220, 220, 0.6)),
            left: BorderSide(
              color: isSelected ? PURPLE : Colors.transparent,
              width: 6,
            ),
            right: BorderSide(
              color: isSelected ? PURPLE : Colors.transparent,
              width: 6,
            ),
          ));

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        textBaseline: textBaseline,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        children: children
            .mapIndexed(
              (index, e) => Padding(
                padding: EdgeInsets.only(bottom: padding),
                child: focusMode
                    ? FAD(
                        forceFocus: index == 0 && forceFocus,
                        autoFocus: index == 0 && autoFocus,
                        customKeys: enableShortcuts
                            ? customKeys?.map(
                                (key, value) => MapEntry(key, () => value?.call(dataList?.elementAt(index))),
                              )
                            : null,
                        onEnterCallback:
                            enableShortcuts ? () => onEnterCallback?.call(dataList?.elementAt(index)) : null,
                        onArrowDownCallback: enableShortcuts && index + 1 < children.length
                            ? () => Actions.invoke(
                                  context,
                                  DirectionalFocusIntent(TraversalDirection.down, ignoreTextFields: ignoreTextFields),
                                )
                            : null,
                        onArrowUpCallback: enableShortcuts && index - 1 >= 0
                            ? () => Actions.invoke(
                                  context,
                                  DirectionalFocusIntent(TraversalDirection.up, ignoreTextFields: ignoreTextFields),
                                )
                            : null,
                        child: (isFocused, isHovered) => FocusScope(
                          canRequestFocus: false,
                          child: AnimatedContainer(
                            duration: 250.milliseconds,
                            decoration: decorationBuilder(isFocused || (isHovered && selectOnHover)),
                            child: e,
                          ),
                        ),
                      )
                    : e,
              ),
            )
            .toList(),
      ),
    );
  }
}
