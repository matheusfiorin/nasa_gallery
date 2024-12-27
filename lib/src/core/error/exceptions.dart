class AppException implements Exception {
  final String message;
  final String? code;
  final Exception? originalException;

  AppException({
    required this.message,
    this.code,
    this.originalException,
  });

  @override
  String toString() =>
      'AppException: $message${code != null ? ' (Code: $code)' : ''}';
}

class ServerException extends AppException {
  ServerException({
    super.message = 'Server error occurred',
    super.code,
    super.originalException,
  });
}

class CacheException extends AppException {
  CacheException({
    super.message = 'Cache error occurred',
    super.code,
    super.originalException,
  });
}

class NetworkException extends AppException {
  NetworkException({
    super.message = 'Network error occurred',
    super.code,
    super.originalException,
  });
}

class InvalidDataException extends AppException {
  InvalidDataException({
    super.message = 'Invalid data received',
    super.code,
    super.originalException,
  });
}
