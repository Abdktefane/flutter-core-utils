import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MobxLoadingPage<T extends BaseViewmodel> extends StatelessWidget {
  const MobxLoadingPage({
    Key key,
    @required this.viewmodel,
    @required this.child,
    this.loadingWidget = const Center(child: CircularProgressIndicator()),
    this.barrierColor = const Color(0xFFc7c7c7),
  }) : super(key: key);

  final Widget child;

  final T viewmodel;
  final Widget loadingWidget;

  final Color barrierColor;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Stack(
        children: [
          AbsorbPointer(child: child, absorbing: viewmodel.isLoading),
          viewmodel.isLoading
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(color: barrierColor.withOpacity(0.3)),
                  child: loadingWidget,
                )
              : Container(width: 0, height: 0),
        ],
      ),
    );
  }
}
