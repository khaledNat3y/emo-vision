import 'package:flutter/services.dart';

class AppConfig {
  static bool get isDevelopment => appFlavor == 'development';
  static bool get isProduction => appFlavor == 'production';
  static String get currentFlavor => appFlavor ?? 'development';

  static String get modeName => isDevelopment
      ? "🚀 Running in Development Mode"
      : "🚀 Running in Production Mode";
}
