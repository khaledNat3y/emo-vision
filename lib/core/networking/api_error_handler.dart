import 'package:dio/dio.dart';
import 'package:facial_emotional_detection_graduation_project/core/networking/dio_exception_type_extension.dart';
import 'package:flutter/material.dart';

import 'api_error_factory.dart';
import 'api_error_model.dart';
import 'local_status_code.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic e) {
    if (e is Exception) {
      if (e is DioException) {
        return e.when(
          connectionError: () => ApiErrorModel(
            message:
            "No internet connection. Please check your Wi-Fi or mobile data.",
            icon: Icons.wifi_off,
            errors: [],
            statusCode: LocalStatusCodes.connectionError,
          ),
          connectionTimeout: () => ApiErrorModel(
            message:
            "The connection took too long. Try checking your internet or try again later.",
            icon: Icons.timer_off,
            statusCode: LocalStatusCodes.connectionTimeout,
            errors: [],
          ),
          sendTimeout: () => ApiErrorModel(
            message: "Request timed out while sending data. Please try again.",
            icon: Icons.send,
            statusCode: LocalStatusCodes.sendTimeout,
            errors: [],
          ),
          receiveTimeout: () => ApiErrorModel(
            message: "Server took too long to respond. Please try again later.",
            icon: Icons.downloading,
            statusCode: LocalStatusCodes.receiveTimeout,
            errors: [],
          ),
          badCertificate: () => ApiErrorModel(
            message:
            "Security issue detected with the server. Connection not secure.",
            icon: Icons.security,
            statusCode: LocalStatusCodes.badCertificate,
            errors: [],
          ),
          badResponse: () {
            try {
              final responseData = e.response?.data;
              final errorsList = <String>[];

              // Check if response data exists and is a Map
              if (responseData != null && responseData is Map<String, dynamic>) {
                final allErrors = responseData['errors'];

                // Check if errors exists and is a Map
                if (allErrors != null && allErrors is Map<String, dynamic>) {
                  allErrors.forEach((key, value) {
                    // ✅ FIXED: Check if value is a List before iterating
                    if (value is List) {
                      for (var error in value) {
                        final String singleErrorMessage = "$key: ${error.toString()}";
                        errorsList.add(singleErrorMessage);
                      }
                    }
                    // Handle if value is a String directly
                    else if (value is String) {
                      errorsList.add("$key: $value");
                    }
                  });
                }
              }

              // Get the main message
              String? mainMessage;
              if (responseData is Map<String, dynamic>) {
                mainMessage = responseData['message']?.toString();
              }

              return ApiErrorModel(
                statusCode: e.response?.statusCode,
                message: mainMessage ?? "An error occurred",
                errors: errorsList,
                icon: Icons.error_outline,
              );
            } catch (error) {
              // Fallback if parsing fails
              return ApiErrorModel(
                statusCode: e.response?.statusCode ?? 500,
                message: "An error occurred while processing the response",
                errors: [],
                icon: Icons.error_outline,
              );
            }
          },
          cancel: () => ApiErrorModel(
            message: "The request was cancelled. Please try again.",
            icon: Icons.cancel,
            statusCode: LocalStatusCodes.cancel,
            errors: [],
          ),
          unknown: () => ApiErrorModel(
            message:
            "Something went wrong. Please check your connection and try again.",
            icon: Icons.error_outline,
            statusCode: LocalStatusCodes.unknown,
            errors: [],
          ),
        );
      } else {
        return ApiErrorFactory.defaultError;
      }
    }
    return ApiErrorFactory.defaultError;
  }
}