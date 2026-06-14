class AppConstants {
  // automatically use the right flavor
  static const emailVerifiedDeepLink = String.fromEnvironment(
    'EMAIL_VERIFIED_DEEP_LINK',
    defaultValue: 'io.supabase.emovision.dev://email-verified',
  );

  static const resetPasswordDeepLink = String.fromEnvironment(
    'RESET_PASSWORD_DEEP_LINK',
    defaultValue: 'io.supabase.emovision.dev://update-password',
  );
}
