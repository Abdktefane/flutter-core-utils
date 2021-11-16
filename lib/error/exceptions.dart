class ServerException implements Exception {
  const ServerException(this.message);
  final String? message;

// You can add a message for example as follow:
//  final String message;
//
//  ServerException(this.message);
}

class NetworkException implements Exception {}

class CacheException implements Exception {}
