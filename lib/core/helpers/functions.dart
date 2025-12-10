import 'package:facial_emotional_detection_graduation_project/core/helpers/spacing.dart';
import 'package:flutter/material.dart';

import '../networking/api_error_model.dart';
import '../theming/app_colors.dart';

void showEnhancedDialog({required BuildContext context, required bool isError, required ApiErrorModel data,}) {
  // Extract dialog details
  final String message;
  final IconData icon;
  final int? statusCode;
  final Color iconColor;
  final Color backgroundColor;

  if (isError) {
    // Handle error state
    message = data.message ?? 'An error occurred';
    icon = data.icon!;
    statusCode = data.statusCode;

    // Customize colors based on status code
    if (statusCode! >= 500) {
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
    message = 'You have successfully logged in!';
    icon = Icons.check_circle_outline;
    statusCode = null;
    iconColor = Colors.green.shade700;
    backgroundColor = Colors.green.shade50;
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
                  isError ? 'Login Failed' : 'Login Successful',
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
          if (isError) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 18,
                    color: Colors.grey.shade700,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _getHelpText(statusCode),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          verticalSpace(8),
          ...data.errors.map((e) {
            return  Text(
              e,
              style: const TextStyle(
                color: AppColors.grey,
                fontSize: 14,
                height: 1.5,
              ),
            );
          }),

        ],
      ),
      actions: isError
          ? [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
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
            // Navigate to home screen or dashboard
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

String _getHelpText(int? statusCode) {
  if (statusCode == null) {
    return 'Please check your credentials and try again.';
  }

  switch (statusCode) {
    case 401:
      return 'Please verify your email and password.';
    case 403:
      return 'Your account may be locked or suspended.';
    case 404:
      return 'The login service could not be found.';
    case 429:
      return 'Please wait a few minutes before trying again.';
    case >= 500:
      return 'Our servers are experiencing issues. Please try again later.';
    default:
      return 'Please check your credentials and try again.';
  }
}

