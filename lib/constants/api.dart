class APIConstants {
  // Network
  // static const String baseUrl = 'https://smartshed-backend.onrender.com';

  // Localhost
  static const String baseUrl = 'http://localhost:8000';

  // Android emulator
  // static const String baseUrl = 'http://10.0.2.2:8000';

  // Auth
  static const String login = '$baseUrl/api/auth/login';
  static const String loginWithGoogle = '$baseUrl/api/auth/login/google';
  static const String register = '$baseUrl/api/auth/register';
  static const String registerWithGoogle = '$baseUrl/api/auth/register/google';
  static const String logout = '$baseUrl/api/auth/logout';

  // Dashboard
  static const String sections = '$baseUrl/api/sections';
  static const String recentlyOpenedForms = '$baseUrl/api/workers/forms';

  // Forms
  static const String createForm = '$baseUrl/api/workers/forms/create';
}
