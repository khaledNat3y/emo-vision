const String appFlavor = String.fromEnvironment(
  'appFlavor',
  defaultValue: 'development',
);

class AppConfig {
  static bool get isDevelopment => appFlavor == 'development';
  static bool get isProduction => appFlavor == 'production';
  static String get currentFlavor => appFlavor;

  static String get modeName => isDevelopment
      ? "🚀 Running in Development Mode"
      : "🚀 Running in Production Mode";
}
