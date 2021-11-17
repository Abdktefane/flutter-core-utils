import 'dart:async';

import 'package:dio/dio.dart';

typedef RetryEvaluator = FutureOr<bool> Function(DioError error);

class RetryOptions {
  /// The number of current retry
  const RetryOptions({
    this.maxAttempts = 3,
    RetryEvaluator? retryEvaluator,
    this.delayInterval = const Duration(milliseconds: 100),
    this.attempt = 1,
  }) : _retryEvaluator = retryEvaluator;

  factory RetryOptions.noRetry() {
    return const RetryOptions(
      maxAttempts: 0,
    );
  }

  static RetryOptions? fromExtra(RequestOptions request) {
    return request.extra[extraKey];
  }

  final int attempt;

  /// The number of maximum retry in case of an error
  final int maxAttempts;

  /// The interval before a retry.
  final Duration delayInterval;

  /// Evaluating if a retry is necessary.regarding the error.
  ///
  /// It can be a good candidate for additional operations too, like
  /// updating authentication token in case of a unauthorized error (be careful
  /// with concurrency though).
  ///
  /// Defaults to [defaultRetryEvaluator].
  RetryEvaluator get retryEvaluator => _retryEvaluator ?? defaultRetryEvaluator;

  final RetryEvaluator? _retryEvaluator;

  static const String extraKey = 'cache_retry_request';

  /// Returns [true] only if the response hasn't been cancelled or got
  /// a bas status code.
  static FutureOr<bool> defaultRetryEvaluator(DioError error) {
    return error.type != DioErrorType.cancel && error.type != DioErrorType.response;
  }

  RetryOptions copyWith({
    int? maxAttempts,
    Duration? delayInterval,
    int? attempt,
  }) =>
      RetryOptions(
        maxAttempts: maxAttempts ?? this.maxAttempts,
        delayInterval: delayInterval ?? this.delayInterval,
        attempt: attempt ?? this.attempt,
      );

  Map<String, dynamic> toExtra() {
    return <String, dynamic>{
      extraKey: this,
    };
  }

  Options toOptions() {
    return Options(extra: toExtra());
  }

  Options mergeIn(Options options) {
    return options.copyWith(
      extra: <String, dynamic>{}..addAll(options.extra ?? <String, dynamic>{})..addAll(toExtra()),
    );
  }
}
