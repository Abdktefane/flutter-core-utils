class ServerException implements Exception {
  final String message;

  ServerException(this.message);
// You can add a message for example as follow:
//  final String message;
//
//  ServerException(this.message);
}

class NetworkException implements Exception {}
class CacheException implements Exception {}