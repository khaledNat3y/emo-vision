class CacheConstants {
  // Tokens (SecureStorage)
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';

  // User info (SharedPreferences)
  static const String userEmail = 'userEmailFromArgs';
  static const String userEmailFromGoogle = 'userEmailFromGoogle';
  static const String userName = 'userName';
  static const String userPhotoUrl = 'userPhotoUrl';

  // Auth method flags (SharedPreferences)
  static const String signInWithGoogle = 'signInWithGoogle';
  static const String isBiometricLogin = 'isBiometric';

  // App state (SharedPreferences)
  static const String hasSeenOnboarding = 'has_seen_onboarding';
  static const String phoneNumber = 'phone_number';
}