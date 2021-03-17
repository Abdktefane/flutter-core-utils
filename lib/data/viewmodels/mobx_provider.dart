import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class MobxProvider<T extends BaseViewmodel> extends StatefulWidget {
  MobxProvider({
    Key key,
    this.viewmodel,
    this.automaticDispose = true,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;
  final T viewmodel;
  final bool automaticDispose;

  @override
  _MobxProviderState<T> createState() => _MobxProviderState<T>();
}

class _MobxProviderState<T extends BaseViewmodel> extends State<MobxProvider<T>> {
  T viewmodel;
  bool automaticDispose;

  @override
  void initState() {
    viewmodel = widget.viewmodel ?? GetIt.I<T>();
    automaticDispose = widget.automaticDispose;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedMobxWidget(
      viewmodel: viewmodel,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    if (automaticDispose) {
      viewmodel.dispose();
    }
    super.dispose();
  }
}

class InheritedMobxWidget<T extends BaseViewmodel> extends InheritedWidget {
  InheritedMobxWidget({
    Key key,
    this.viewmodel,
    @required this.child,
  })  : assert(child != null),
        super(key: key, child: child);

  final Widget child;
  final T viewmodel;

  static T of<T extends BaseViewmodel>(BuildContext context) {
    final viewmodel = context.dependOnInheritedWidgetOfExactType<InheritedMobxWidget<T>>()?.viewmodel;
    if (viewmodel == null) {
      throw Exception(
        'ERROR ==> InheritedMobxWidget can\'t find $T in context',
      );
    }
    return viewmodel;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
