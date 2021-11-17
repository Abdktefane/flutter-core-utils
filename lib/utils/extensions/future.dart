import 'dart:async';

import 'package:core_sdk/utils/network_result.dart';

extension FutureExtension<T> on Future<NetworkResult<T>> {
  Future<NetworkResult<R>> whenSuccessWrapped<R>(FutureOr<R> Function(T res) onSuccess) {
    return then((res) => res.getOrThrow()).then((res) => onSuccess(res)).then((res) => Success(res));
  }

  Future<R> whenSuccess<R>(FutureOr<R> Function(T res) onSuccess) {
    return then((res) => res.getOrThrow()).then((res) => onSuccess(res));
  }
}
