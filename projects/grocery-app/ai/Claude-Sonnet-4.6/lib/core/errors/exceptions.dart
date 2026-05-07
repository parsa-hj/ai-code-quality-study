/// Custom exception types thrown by the data layer.
/// Controllers catch these and convert them to AppError types for the UI.

/// Base exception.
class AppException implements Exception {
  final String message;
  final String? code;

  const AppException({required this.message, this.code});

  @override
  String toString() => 'AppException: $message (code: $code)';
}

/// Thrown when there is no network connectivity.
class NoInternetException extends AppException {
  const NoInternetException()
      : super(
          message: 'No internet connection. Please check your network.',
          code: 'NO_INTERNET',
        );
}

/// Thrown when the server returns a non-2xx response.
class ServerException extends AppException {
  final int? statusCode;

  const ServerException({
    required String message,
    this.statusCode,
    String? code,
  }) : super(message: message, code: code);
}

/// Thrown when authentication fails (invalid credentials, token expired).
class AuthException extends AppException {
  const AuthException({
    String message = 'Authentication failed.',
    String? code,
  }) : super(message: message, code: code);
}

/// Thrown when the requested resource is not found.
class NotFoundException extends AppException {
  const NotFoundException({
    String message = 'Resource not found.',
    String? code,
  }) : super(message: message, code: code);
}

/// Thrown when local cache/storage fails.
class CacheException extends AppException {
  const CacheException({
    String message = 'Local storage error.',
    String? code,
  }) : super(message: message, code: code);
}

/// Thrown for input validation failures.
class ValidationException extends AppException {
  const ValidationException({required String message, String? code})
      : super(message: message, code: code);
}
