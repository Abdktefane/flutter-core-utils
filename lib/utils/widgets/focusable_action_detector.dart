import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FAD extends StatefulWidget {
  const FAD({
    Key? key,
    required this.child,
    this.focusNode,
    this.autoFocus = true,
    this.forceFocus = false,
    this.rebuildOnFocus = true,
    this.rebuildOnHover = true,
    this.onEscCallback,
    this.onTabCallback,
    this.onShiftTabCallback,
    this.onEnterCallback,
    this.onHoverCallback,
    this.onArrowUpCallback,
    this.onArrowDownCallback,
    this.onArrowLeftCallback,
    this.onArrowRightCallback,
    this.onShowFocusHighlight,
    this.onCtrlEnterCallback,
    this.onDeleteCallback,
    this.customKeys,
  }) : super(key: key);

  final VoidCallback? onEscCallback;
  final VoidCallback? onTabCallback;
  final VoidCallback? onShiftTabCallback;
  final VoidCallback? onCtrlEnterCallback;
  final VoidCallback? onEnterCallback;
  final VoidCallback? onArrowUpCallback;
  final VoidCallback? onArrowDownCallback;
  final VoidCallback? onArrowLeftCallback;
  final VoidCallback? onDeleteCallback;
  final VoidCallback? onArrowRightCallback;
  final ValueChanged<bool>? onHoverCallback;
  final ValueChanged<bool>? onShowFocusHighlight;
  final Map<LogicalKeySet, VoidCallback?>? customKeys;
  final Widget Function(bool isFocused, bool isHovered) child;
  final FocusNode? focusNode;
  final bool autoFocus;
  final bool forceFocus;
  final bool rebuildOnFocus;
  final bool rebuildOnHover;

  @override
  _FADState createState() => _FADState();
}

class _FADState extends State<FAD> {
  final focusNode = FocusNode();

  bool isHovered = false;
  bool isFocused = false;
  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.forceFocus) {
      requestFocus();
    }
  }

  void requestFocus() {
    (widget.focusNode ?? focusNode).requestFocus();
  }

  @override
  void didUpdateWidget(FAD oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.forceFocus != widget.forceFocus) {
      if (widget.forceFocus) {
        requestFocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) => !kIsWeb
      ? widget.child(false, false)
      : FocusableActionDetector(
          focusNode: widget.focusNode ?? focusNode,
          autofocus: widget.autoFocus,
          shortcuts: _initShortcuts,
          actions: _initActions,
          onShowHoverHighlight: widget.onHoverCallback != null || widget.rebuildOnHover
              ? (isHovered) {
                  if (isHovered) {
                    requestFocus();
                  }
                  setState(() {
                    this.isHovered = isHovered;
                    widget.onHoverCallback?.call(isHovered);
                  });
                }
              : null,
          onShowFocusHighlight: widget.onShowFocusHighlight != null || widget.rebuildOnFocus
              ? (isFocused) {
                  setState(() {
                    this.isFocused = isFocused;
                    widget.onShowFocusHighlight?.call(isFocused);
                  });
                }
              : null,
          child: widget.child(isFocused, isHovered),
        );

  Map<LogicalKeySet, _Intent> get _initShortcuts => <LogicalKeySet, _Intent>{
        if (widget.onEscCallback != null) LogicalKeySet(LogicalKeyboardKey.escape): const _Intent.esc(),
        if (widget.onTabCallback != null) LogicalKeySet(LogicalKeyboardKey.tab): const _Intent.tab(),
        if (widget.onShiftTabCallback != null)
          LogicalKeySet.fromSet({LogicalKeyboardKey.tab, LogicalKeyboardKey.shift}): const _Intent.shiftTab(),
        if (widget.onEnterCallback != null) LogicalKeySet(LogicalKeyboardKey.enter): const _Intent.enter(),
        if (widget.onArrowUpCallback != null) LogicalKeySet(LogicalKeyboardKey.arrowUp): const _Intent.arrowUp(),
        if (widget.onArrowDownCallback != null) LogicalKeySet(LogicalKeyboardKey.arrowDown): const _Intent.arrowDown(),
        if (widget.onArrowLeftCallback != null) LogicalKeySet(LogicalKeyboardKey.arrowLeft): const _Intent.arrowLeft(),
        if (widget.onArrowRightCallback != null)
          LogicalKeySet(LogicalKeyboardKey.arrowRight): const _Intent.arrowRight(),
        if (widget.onCtrlEnterCallback != null)
          LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.enter): const _Intent.ctrlEnter(),
        if (widget.onDeleteCallback != null) LogicalKeySet(LogicalKeyboardKey.delete): const _Intent.delete(),
        if (widget.customKeys != null) ...{
          ...Map.fromIterable(widget.customKeys!.keys, value: (key) => _Intent.custom(key, widget.customKeys![key])),
        }
      };

  void _actionHandler(_Intent intent) {
    switch (intent.type) {
      case _IntentType.Esc:
        widget.onEscCallback?.call();
        break;
      case _IntentType.Tab:
        widget.onTabCallback?.call();
        break;
      case _IntentType.ShifTab:
        widget.onShiftTabCallback?.call();
        break;
      case _IntentType.Enter:
        widget.onEnterCallback?.call();
        break;
      case _IntentType.ArrowUp:
        widget.onArrowUpCallback?.call();
        break;
      case _IntentType.ArrowDown:
        widget.onArrowDownCallback?.call();
        break;
      case _IntentType.ArrowLeft:
        widget.onArrowLeftCallback?.call();
        break;
      case _IntentType.ArrowRight:
        widget.onArrowRightCallback?.call();
        break;
      case _IntentType.CtrlEnter:
        widget.onCtrlEnterCallback?.call();
        break;
      case _IntentType.Delete:
        widget.onDeleteCallback?.call();
        break;
      case _IntentType.Custom:
        intent.callback?.call();
        break;
    }
  }

  Map<Type, Action<Intent>> get _initActions => <Type, Action<Intent>>{
        _Intent: CallbackAction<_Intent>(onInvoke: (intent) => _actionHandler(intent)),
      };
}

class _Intent extends Intent {
  const _Intent({required this.type, this.key, this.callback});
  const _Intent.esc()
      : type = _IntentType.Esc,
        key = null,
        callback = null;
  const _Intent.tab()
      : type = _IntentType.Tab,
        key = null,
        callback = null;
  const _Intent.shiftTab()
      : type = _IntentType.ShifTab,
        key = null,
        callback = null;
  const _Intent.enter()
      : type = _IntentType.Enter,
        key = null,
        callback = null;
  const _Intent.arrowUp()
      : type = _IntentType.ArrowUp,
        key = null,
        callback = null;
  const _Intent.arrowDown()
      : type = _IntentType.ArrowDown,
        key = null,
        callback = null;
  const _Intent.arrowLeft()
      : type = _IntentType.ArrowLeft,
        key = null,
        callback = null;
  const _Intent.arrowRight()
      : type = _IntentType.ArrowRight,
        key = null,
        callback = null;
  const _Intent.ctrlEnter()
      : type = _IntentType.CtrlEnter,
        key = null,
        callback = null;
  const _Intent.delete()
      : type = _IntentType.Delete,
        key = null,
        callback = null;
  const _Intent.custom(LogicalKeySet key, VoidCallback? callback)
      : type = _IntentType.Custom,
        this.key = key,
        this.callback = callback;

  final _IntentType type;
  final LogicalKeySet? key;
  final VoidCallback? callback;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Intent &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          key == other.key &&
          callback == callback;

  @override
  int get hashCode => key == null ? type.hashCode : type.hashCode + key.hashCode;
}

enum _IntentType {
  Esc,
  Tab,
  ShifTab,
  Enter,
  ArrowUp,
  ArrowDown,
  ArrowLeft,
  ArrowRight,
  CtrlEnter,
  Delete,
  Custom,
}
