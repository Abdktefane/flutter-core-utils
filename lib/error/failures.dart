import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  final String message;

  Failure(this.message, [this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => properties;
}

// General failures
class UnknownFailure extends Failure {
  UnknownFailure(String message) : super(message);
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  NetworkFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  CacheFailure(String message) : super(message);
}

class InvalidInputFailure extends Failure {
  InvalidInputFailure(String message) : super(message);
}