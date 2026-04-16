class ApiConstants {
  static const String baseUrl = 'https://accessories-eshop.runasp.net';

  // Auth endpoints
  static const String login = '/api/auth/login';
  static const String register = '/api/auth/register';
  static const String verifyEmail = '/api/auth/verify-email';
  static const String logout = '/api/auth/logout';
  static const String me = '/api/auth/me';
  static const String refreshToken = '/api/auth/refresh-token';
  static const String forgotPassword = "/api/auth/forgot-password";
  static const String resetPassword = "/api/auth/reset-password";
}
