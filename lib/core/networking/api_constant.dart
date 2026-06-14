class ApiConstants {
  static const String baseUrl = 'https://accessories-eshop.runasp.net';
  static const String videoProcessingBaseUrl =
      'https://emovisiondeployment-production-8e39.up.railway.app';

  // Auth endpoints
  static const String login = '/api/auth/login';
  static const String register = '/api/auth/register';
  static const String verifyEmail = '/api/auth/verify-email';
  static const String logout = '/api/auth/logout';
  static const String me = '/api/auth/me';
  static const String refreshToken = '/api/auth/refresh-token';
  static const String forgotPassword = "/api/auth/forgot-password";
  static const String resetPassword = "/api/auth/reset-password";
  static const String resendOtp = "/api/auth/resend-otp";
  static const String uploadVideo = "/predict";
}
