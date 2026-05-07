/// Custom error types for the app.
/// Maps different failure types to user-friendly messages.
abstract class AppError {
  final String message;
  final String? code;
  final dynamic originalError;

  const AppError({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  String toString() => 'AppError(code: $code, message: $message)';
}

/// Network-related errors (no connection, timeout).
class NetworkError extends AppError {
  const NetworkError({
    String message = 'No internet connection. Please check your network.',
    String? code,
    dynamic originalError,
  }) : super(message: message, code: code, originalError: originalError);
}

/// Server returned an error response (4xx, 5xx).
class ServerError extends AppError {
  final int? statusCode;

  const ServerError({
    required String message,
    this.statusCode,
    String? code,
    dynamic originalError,
  }) : super(message: message, code: code, originalError: originalError);
}

/// Authentication / authorization errors.
class AuthError extends AppError {
  const AuthError({
    String message = 'Authentication failed. Please login again.',
    String? code,
    dynamic originalError,
  }) : super(message: message, code: code, originalError: originalError);
}

/// Resource not found.
class NotFoundError extends AppError {
  const NotFoundError({
    String message = 'The requested resource was not found.',
    String? code,
    dynamic originalError,
  }) : super(message: message, code: code, originalError: originalError);
}

/// Validation / bad input error.
class ValidationError extends AppError {
  const ValidationError({
    required String message,
    String? code,
    dynamic originalError,
  }) : super(message: message, code: code, originalError: originalError);
}

/// Unexpected / unknown error.
class UnknownError extends AppError {
  const UnknownError({
    String message = 'Something went wrong. Please try again.',
    String? code,
    dynamic originalError,
  }) : super(message: message, code: code, originalError: originalError);
}
