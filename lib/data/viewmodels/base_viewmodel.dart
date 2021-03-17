import 'package:core_sdk/error/failures.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/colors.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/navigator/nav_order.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';

part 'base_viewmodel.g.dart';

typedef ContextHandler<T> = T Function(BuildContext context);

abstract class BaseViewmodel extends _BaseViewmodelBase with _$BaseViewmodel {
  BaseViewmodel(Logger logger) : super(logger);
}

abstract class _BaseViewmodelBase with Store {
  _BaseViewmodelBase(this.logger);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @protected
  final Logger logger;

  @observable
  bool isLoading = false;

  @observable
  NavOrder navigator;

  @observable
  ContextHandler contextHandler;

  @observable
  String connectionError;

  @action
  void navigate({@required NavOrder order}) {
    navigator = order;
  }

  @action
  void getContext(ContextHandler handler) {
    contextHandler = handler;
  }

  @action
  void startLoading() {
    isLoading = true;
  }

  @action
  void stopLoading() {
    isLoading = false;
  }

  @action
  Future<T> loadingRequest<T>(Future<T> Function() callback) async {
    connectionError = null;
    startLoading();
    final response = await callback();
    stopLoading();
    return response;
  }

  // ignore: todo
  // TODO(abd): add general error handler with snackbar or toast or both.
  @action
  void showSnack(
    String message, {
    VoidCallback action,
    Color backgroundColor = DARK_GREY,
    Duration duration = const Duration(minutes: 10),
  }) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: duration,
        action: action != null
            ? SnackBarAction(
                label: 'retry',
                onPressed: action,
                disabledTextColor: WHITE,
                textColor: WHITE,
              )
            : null,
        content: Text(
          message ?? 'unknown',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }

  void unknownErrorHandler(dynamic cause) {
    getContext((context) {
      Fluttertoast.showToast(
        msg: context.translate('msg_something_wrong'),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: DARK_GREY,
        textColor: WHITE,
        fontSize: 16.0,
      );
    });
  }

  @protected
  ObservableFuture<T> futureWrapper<T>(
    Future<T> Function() block, {
    void Function(String) catchBlock,
  }) {
    connectionError = null;
    return ObservableFuture(_wrapError<T>(
      block(),
      block: catchBlock,
    ));
  }

  Future<T> _wrapError<T>(
    Future<T> future, {
    void Function(String) block,
  }) =>
      future.catchError((error) {
        if (error is CallException && error.cause is NetworkFailure) {
          logger.e('NetworkError in base view model $error');
          connectionError = 'msg_no_internet';
        } else if (error is CallException && error.cause is ServerFailure) {
          logger.e('ServerFailure in base view model ${error.cause.message}');
          block(error.cause.message);
        } else {
          logger.e('unknown error in base view model $error');
          unknownErrorHandler(error);
        }
        throw error;
      });

  Future<void> dispose() {}

  //  async {
  //   await cancelSubscription();
  // }

}
