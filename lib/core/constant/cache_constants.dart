bool isFirstLaunch = true;
bool isBiometric = false;
bool isUserLoggedInWithGoogle = false;
class CacheConstants {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String phoneNumber = 'phone_number';
  static const String hasSeenOnboarding = 'has_seen_onboarding';
  static const String isBiometricLogin = 'isBiometric';
  static const String userEmail = 'userEmailFromArgs';
  static const String userEmailFromGoogle = 'userEmailFromGoogle';
  static const String signInWithGoogle = 'signInWithGoogle';
}