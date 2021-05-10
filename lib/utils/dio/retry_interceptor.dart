import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../Fimber/Logger.dart';
import 'retry_options.dart';

/// An interceptor that will try to send failed request again
class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required this.dio,
    required this.logger,
    RetryOptions? options,
  }) : options = options ?? const RetryOptions();

  final Dio dio;
  final Logger logger;
  final RetryOptions options;

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    // RetryOptions extra = RetryOptions.fromExtra(err.requestOptions) ?? options;
    RetryOptions extra = RetryOptions.fromExtra(err.requestOptions);

    final bool shouldRetry = extra.attempt <= extra.maxAttempts && await options.retryEvaluator(err);

    if (!shouldRetry) {
      return super.onError(err, handler);
    }
    final int nextDelay = extra.attempt * extra.attempt * extra.delayInterval.inMilliseconds;

    if (nextDelay > 0) {
      await Future<void>.delayed(Duration(milliseconds: nextDelay));
    }

    // Update options to decrease retry count before new try
    logger.w(
        'schedule try for [${err.requestOptions.uri}] (current attempt: ${extra.attempt}, delayTime: $nextDelay, maxAttempts: ${extra.maxAttempts}, remaining tries: ${extra.maxAttempts - extra.attempt}, error: ${err.error})');
    extra = extra.copyWith(attempt: extra.attempt + 1);
    err.requestOptions.extra = err.requestOptions.extra..addAll(extra.toExtra());
    try {
      // We retry with the updated options
      return await dio.request /* <Map<String, dynamic>> */ (
        err.requestOptions.path,
        data: err.requestOptions.data,
        queryParameters: err.requestOptions.queryParameters,
        cancelToken: err.requestOptions.cancelToken,
        // options: err.requestOptions.,
        onSendProgress: err.requestOptions.onSendProgress,
        onReceiveProgress: err.requestOptions.onReceiveProgress,
      );
    } catch (e) {
      return e;
    }
  }
}
