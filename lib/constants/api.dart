class APIConstants {
  static const String baseUrl = 'https://smartshed-backend.onrender.com';

  // Auth
  static const String login = '$baseUrl/api/auth/login';
  static const String loginWithGoogle = '$baseUrl/api/auth/login/google';
  static const String register = '$baseUrl/api/auth/register';
  static const String registerWithGoogle = '$baseUrl/api/auth/register/google';
  static const String logout = '$baseUrl/api/auth/logout';
}
