import 'package:facial_emotional_detection_graduation_project/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'logger.dart';

/// Shows an enhanced dialog for errors or success messages.
///
/// For errors: pass [isError] = true, [message], optional [statusCode] and [errors].
/// For success: pass [isError] = false, [message], optional [successTitle].
void showEnhancedDialog({
  required BuildContext context,
  required bool isError,
  required String message,
  int? statusCode,
  List<String> errors = const [],
  IconData? icon,
  String? successTitle,
  String? errorTitle,
}) {
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;
  final Color iconColor;
  final String title;
  final IconData dialogIcon;

  if (isError) {
    dialogIcon = icon ?? Icons.error_outline;
    title = errorTitle ?? _getErrorTitle(statusCode);

    if (statusCode != null && statusCode >= 500) {
      iconColor = Colors.orange.shade700;
    } else if (statusCode == 401 || statusCode == 403) {
      iconColor = Colors.red.shade700;
    } else {
      iconColor = Colors.amber.shade700;
    }
  } else {
    dialogIcon = Icons.check_circle_outline;
    iconColor = Colors.green.shade700;
    title = successTitle ?? 'Success';
  }

  final indicatorBackgroundColor = iconColor.withValues(
    alpha: isDark ? 0.18 : 0.12,
  );

  showDialog(
    context: context,
    barrierDismissible: !isError,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: indicatorBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(dialogIcon, color: iconColor, size: 28),
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
                      color: theme.textTheme.titleSmall?.color,
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
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: theme.colorScheme.onSurface,
            ),
          ),
          if (isError && errors.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: theme.colorScheme.outline),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 18,
                        color: theme.colorScheme.onSurface,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Details:',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(8),
                  ...errors.map((e) {
                    Logger.error('Error: $e');
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• ',
                            style: TextStyle(
                              color: theme.colorScheme.onSurface,
                              fontSize: 14,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              e,
                              style: TextStyle(
                                color: theme.colorScheme.onSurface,
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
                color: theme.colorScheme.primary.withValues(
                  alpha: isDark ? 0.18 : 0.08,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _getHelpText(statusCode),
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.colorScheme.primary,
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
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ]
          : [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: iconColor,
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
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
    ),
  );
}

String _getErrorTitle(int? statusCode) {
  if (statusCode == null) return 'Error';
  if (statusCode == 400) return 'Validation Error';
  if (statusCode == 401) return 'Authentication Failed';
  if (statusCode == 403) return 'Access Denied';
  if (statusCode == 404) return 'Not Found';
  if (statusCode >= 500) return 'Server Error';
  return 'Error';
}

String _getHelpText(int? statusCode) {
  if (statusCode == null) return 'Please check your input and try again.';
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

Future<void> launchUrlToEmoVisionWebsite() async {
  if (!await launchUrl(Uri.parse('https://emovision.kofino.net'))) {
    throw Exception(
      'Could not launch ${Uri.parse('https://emovision.kofino.net')}',
    );
  }
}

void showToast(BuildContext context, String message) {
  final OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 100,
      left: 24,
      right: 24,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );

  Overlay.of(context).insert(overlayEntry);

  Future.delayed(const Duration(seconds: 5), () {
    overlayEntry.remove();
  });
}
