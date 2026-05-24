// App state flags (set at startup)
bool isFirstLaunch = false;
bool isBiometric = false;
bool isUserLoggedIn = false;

class CacheConstants {
  // Auth tokens (SecureStorage) - Supabase
  static const String supabaseAccessToken = 'supabase_access_token';

  // User info (SharedPreferences)
  static const String userEmail = 'userEmail';
  static const String userName = 'userName';
  static const String userPhotoUrl = 'userPhotoUrl';
  static const String isUserAuthenticated = 'isUserAuthenticated';

  // App state (SharedPreferences)
  static const String hasSeenOnboarding = 'has_seen_onboarding';
  static const String isBiometricLogin = 'isBiometric';
}
