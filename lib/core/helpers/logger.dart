import 'package:flutter/foundation.dart';

class Logger {
  /// General log
  static void log(String message) {
    if (kDebugMode) {
      debugPrint("[LOG] $message");
    }
  }

  /// Debug log
  static void debug(String message) {
    if (kDebugMode) {
      debugPrint("🐛 [DEBUG] $message");
    }
  }

  /// Info log
  static void info(String message) {
    if (kDebugMode) {
      debugPrint("ℹ️ [INFO] $message");
    }
  }

  /// Success log
  static void success(String message) {
    if (kDebugMode) {
      debugPrint("✅ [SUCCESS] $message");
    }
  }

  /// Warning log
  static void warning(String message) {
    if (kDebugMode) {
      debugPrint("⚠️ [WARNING] $message");
    }
  }

  /// Error log
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint("❌ [ERROR] $message");
      if (error != null) debugPrint("   ↳ Error: $error");
      if (stackTrace != null) debugPrint("   ↳ StackTrace: $stackTrace");
    }
  }
}
