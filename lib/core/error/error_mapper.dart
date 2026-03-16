import 'package:dio/dio.dart';
import 'app_exception.dart';

/// Maps [DioException] and generic exceptions to [AppException] subtypes.
abstract final class ErrorMapper {
  static AppException map(Object error) {
    if (error is AppException) return error;

    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const NetworkException('Request timed out. Please try again.');
        case DioExceptionType.connectionError:
          return const NetworkException(
            'Could not connect. Check your internet connection.',
          );
        case DioExceptionType.badResponse:
          final status = error.response?.statusCode;
          return NetworkException(
            'Server error (${status ?? 'unknown'})',
            statusCode: status,
          );
        default:
          return NetworkException(error.message ?? 'Network error');
      }
    }

    if (error is FormatException) {
      return ParseException('Invalid data format: ${error.message}');
    }

    return NetworkException(error.toString());
  }
}
