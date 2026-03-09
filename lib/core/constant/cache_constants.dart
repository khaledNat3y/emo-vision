bool isFirstLaunch = true;
bool isBiometric = false;
bool isUserLoggedInWithGoogle = false;
bool isUserLoggedInWithEmailAndPasswordAndHasValidAccessToken = false;

class CacheConstants {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String phoneNumber = 'phone_number';
  static const String hasSeenOnboarding = 'has_seen_onboarding';
  static const String isBiometricLogin = 'isBiometric';
  static const String userEmail = 'userEmailFromArgs';
  static const String userEmailFromGoogle = 'userEmailFromGoogle';
  static const String userName = 'userName';
  static const String userNameFromGoogle = 'userNameFromGoogle';
  static const String userNameFromBiometric = 'userNameFromBiometric';
  static const String userEmailFromBiometric = 'userEmailFromBiometric';
  static const String userPhotoUrl = 'userPhotoUrl';
  static const String userPhotoUrlFromGoogle = 'userPhotoUrlFromGoogle';
  static const String signInWithGoogle = 'signInWithGoogle';
}