import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/mobx.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class MobxFutureBuilder<T> extends StatelessWidget {
  const MobxFutureBuilder({
    Key key,
    @required this.future,
    @required this.onSuccess,
    @required this.onError,
    @required this.onLoading,
    this.animatedSwitcherDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  final ObservableFuture<T> future;
  final Widget Function(dynamic) onError;
  final Widget Function() onLoading;
  final Widget Function(T) onSuccess;
  final Duration animatedSwitcherDuration;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return AnimatedSwitcher(
          duration: animatedSwitcherDuration,
          child: future.isFailure
              ? onError(future.error)
              : future.isPending
                  ? onLoading()
                  : future.isSuccess
                      ? onSuccess(future.value)
                      : SizedBox(),
        );
        // if (future.isFailure) return onError(future.error);

        // if (future.isPending) return onLoading();

        // if (future.isSuccess) return onSuccess(future.value);

        // return SizedBox();
      },
    );
  }
}
