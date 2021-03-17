import 'package:core_sdk/error/failures.dart';

abstract class NetworkResult<T> {
  bool get isSuccess => this is Success || false;
  bool get isNetworkFailure => this is NetworkFailure || false;
  bool get isNetworkError => this is NetworkError || false;

  // ignore: always_specify_types
  T getOrNull() => isSuccess ? (this as Success<T>).data : null;

  //FIXME not working with test
  T getOrThrow() => isSuccess ? (this as Success<T>).data : throw getException();

  Failure getFailure() => (this as NetworkError<T>).cause;

  CallException getException() {
    CallException ex;
    if (isNetworkFailure) {
      ex = CallException((this as NetworkError<T>).cause);
    }
    if (isNetworkError) {
      ex = CallException((this as NetworkError<T>).cause);
    }
    return ex;
  }
}

class Success<T> extends NetworkResult<T> {
  Success(this.data);

  final T data;

  @override
  String toString() => 'Success<$T}>:{$data}';
}

class NetworkError<T> extends NetworkResult<T> {
  NetworkError(this.cause);
  Failure cause;
  @override
  String toString() => 'NetworkError<$T>:{$cause}';
}

class CallException implements Exception {
  const CallException(this.cause);
  final Failure cause;
}
