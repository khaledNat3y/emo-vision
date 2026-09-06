import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class Logger {
  /// General log
  static void log(String message) {
    if (appFlavor == 'development') {
      debugPrint("[LOG] $message");
    }
  }

  /// Debug log
  static void debug(String message) {
    if (appFlavor == 'development') {
      debugPrint("🐛 [DEBUG] $message");
    }
  }

  /// Info log
  static void info(String message) {
    if (appFlavor == 'development') {
      debugPrint("ℹ️ [INFO] $message");
    }
  }

  /// Success log
  static void success(String message) {
    if (appFlavor == 'development') {
      debugPrint("✅ [SUCCESS] $message");
    }
  }

  /// Warning log
  static void warning(String message) {
    if (appFlavor == 'development') {
      debugPrint("⚠️ [WARNING] $message");
    }
  }

  /// Error log
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (appFlavor == 'development') {
      debugPrint("❌ [ERROR] $message");
      if (error != null) debugPrint("   ↳ Error: $error");
      if (stackTrace != null) debugPrint("   ↳ StackTrace: $stackTrace");
    }
  }
}
