import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String handle(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';

      case DioExceptionType.connectionTimeout:
        return 'Connection timed out. Please try again.';

      case DioExceptionType.receiveTimeout:
        return 'Server took too long to respond. Please try again.';

      case DioExceptionType.sendTimeout:
        return 'Request timed out while sending. Please try again.';

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.cancel:
        return 'Request was cancelled. Please try again.';

      default:
        return 'Something went wrong. Please try again.';
    }
  }

  static String _handleBadResponse(DioException error) {
    try {
      final data = error.response?.data;

      if (data is Map<String, dynamic>) {
        // 1. Direct message
        final message = data['message']?.toString();
        if (message != null && message.isNotEmpty) {
          return message;
        }

        // 2. Laravel-style errors
        final errors = data['errors'];
        if (errors is Map<String, dynamic>) {
          final firstError = errors.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            return firstError.first.toString();
          }
        }
      }
    } catch (_) {}

    return 'Server error (${error.response?.statusCode}). Please try again.';
  }
}
