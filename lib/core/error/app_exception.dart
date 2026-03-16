/// App-level exception hierarchy.
sealed class AppException implements Exception {
  const AppException(this.message);
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// Raised when a network/HTTP request fails.
final class NetworkException extends AppException {
  const NetworkException(super.message, {this.statusCode});
  final int? statusCode;
}

/// Raised when JSON parsing fails or a required field is missing.
final class ParseException extends AppException {
  const ParseException(super.message);
}

/// Raised when the device is offline and no cache is available.
final class NoDataException extends AppException {
  const NoDataException(super.message);
}
