class ServerException implements Exception {
  final String errorMessage;
  final num statusCode;
  final String errorKey;
  ServerException({required this.statusCode, required this.errorKey, required this.errorMessage});
}

class CustomDioException implements Exception {}

class CacheException implements Exception {}
