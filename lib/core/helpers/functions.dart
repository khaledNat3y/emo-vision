import 'package:facial_emotional_detection_graduation_project/core/helpers/spacing.dart';
import 'package:flutter/material.dart';

import '../networking/api_error_model.dart';
import '../theming/app_colors.dart';
import 'logger.dart';

void showEnhancedDialog({
  required BuildContext context,
  required bool isError,
  required ApiErrorModel data,
  String? successTitle,
  String? successMessage,
  String? errorTitle,
}) {
  // Extract dialog details
  final String message;
  final IconData icon;
  final int? statusCode;
  final Color iconColor;
  final Color backgroundColor;
  final String title;

  if (isError) {
    // Handle error state
    message = data.message ?? 'An error occurred';
    icon = data.icon ?? Icons.error_outline;
    statusCode = data.statusCode;
    title = errorTitle ?? _getErrorTitle(statusCode);

    // Customize colors based on status code
    if (statusCode != null && statusCode >= 500) {
      iconColor = Colors.orange.shade700;
      backgroundColor = Colors.orange.shade50;
    } else if (statusCode == 401 || statusCode == 403) {
      iconColor = Colors.red.shade700;
      backgroundColor = Colors.red.shade50;
    } else {
      iconColor = Colors.amber.shade700;
      backgroundColor = Colors.amber.shade50;
    }
  } else {
    // Handle success state
    message = successMessage ?? 'Operation completed successfully!';
    icon = Icons.check_circle_outline;
    statusCode = null;
    iconColor = Colors.green.shade700;
    backgroundColor = Colors.green.shade50;
    title = successTitle ?? 'Success';
  }

  showDialog(
    context: context,
    barrierDismissible: !isError,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (statusCode != null)
                  Text(
                    'Error Code: $statusCode',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
          ),
          if (isError && data.errors.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 18,
                        color: Colors.grey.shade700,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Details:',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(8),
                  ...data.errors.map((e) {
                    Logger.error('Error: $e');
                    Logger.error('Error: ${data.errors.first}');
                    Logger.error('Error: ${data.errors[0]}');
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• ',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 14,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              data.errors[0],
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
          if (isError) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 18,
                    color: Colors.blue.shade700,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _getHelpText(statusCode),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
      actions: isError
          ? [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'OK',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ]
          : [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade600,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Continue',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
    ),
  );
}

String _getErrorTitle(int? statusCode) {
  if (statusCode == null) {
    return 'Error';
  }

  if (statusCode == 400) {
    return 'Validation Error';
  } else if (statusCode == 401) {
    return 'Authentication Failed';
  } else if (statusCode == 403) {
    return 'Access Denied';
  } else if (statusCode == 404) {
    return 'Not Found';
  } else if (statusCode >= 500) {
    return 'Server Error';
  } else {
    return 'Error';
  }
}

String _getHelpText(int? statusCode) {
  if (statusCode == null) {
    return 'Please check your input and try again.';
  }

  switch (statusCode) {
    case 400:
      return 'Please check the information you provided and try again.';
    case 401:
      return 'Please verify your email and password.';
    case 403:
      return 'Your account may be locked or suspended.';
    case 404:
      return 'The requested resource could not be found.';
    case 429:
      return 'Please wait a few minutes before trying again.';
    case >= 500:
      return 'Our servers are experiencing issues. Please try again later.';
    default:
      return 'Please check your input and try again.';
  }
}