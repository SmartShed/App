class APIConstants {
  // AWS EC2
  // static const String baseUrl = 'http://13.233.17.93';

  // Render
  // static const String baseUrl = 'https://smartshed-backend.onrender.com';

  // Localhost
  // static const String baseUrl = 'http://localhost:8000';

  static late String baseUrl;

  static void setBaseUrl(String url) {
    baseUrl = url;
  }

  // Auth
  static String me = '$baseUrl/api/auth/me';
  static String login = '$baseUrl/api/auth/login';
  static String loginWithGoogle = '$baseUrl/api/auth/login/google';
  static String register = '$baseUrl/api/auth/register';
  static String registerWithGoogle = '$baseUrl/api/auth/register/google';
  static String forgotPassword = '$baseUrl/api/auth/forgot-password';
  static String validateOTP = '$baseUrl/api/auth/validate-otp';
  static String resetPassword = '$baseUrl/api/auth/reset-password';
  static String logout = '$baseUrl/api/auth/logout';

  static String getUsers = '$baseUrl/api/users';

  // Dashboard
  static String sections = '$baseUrl/api/sections';
  static String recentlyOpenedForms = '$baseUrl/api/workers/forms';

  // Sections
  static String formsBySectionIdOrName =
      '$baseUrl/api/sections/:idOrName/forms';

  static String openedFormsBySectionIdOrName =
      '$baseUrl/api/sections/:idOrName/opened-forms';

  // Forms
  static String createForm = '$baseUrl/api/workers/forms/create';
  static String getForm = '$baseUrl/api/workers/forms/:id';
  static String recentlyOpenedFormsForSection =
      '$baseUrl/api/workers/section/:idOrName/forms';

  // Forms Answering
  static String saveForm = '$baseUrl/api/workers/forms/:id/draft';
  static String submitForm = '$baseUrl/api/workers/forms/:id/submit';

  // Creation
  static String employees = '$baseUrl/api/create/employees';
  static String addSection = '$baseUrl/api/create/section';
  static String addForms = '$baseUrl/api/create/forms';
  static String addSubForms = '$baseUrl/api/create/sub-forms';
  static String addQuestions = '$baseUrl/api/create/questions';

  static String deleteUsers = '$baseUrl/api/delete/users';
}
