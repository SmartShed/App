class APIConstants {
  // AWS EC2
  static const String baseUrl = 'http://13.233.17.93';

  // Render
  // static const String baseUrl = 'https://smartshed-backend.onrender.com';

  // Localhost
  // static const String baseUrl = 'http://localhost:8000';

  // Constants for Google Sign In API
  static const String googleClientId =
      "733510285262-g2o3upi13pbohg452f9esash3tlmf88s.apps.googleusercontent.com";
  static const String googleApiKey = 'AIzaSyAPOJ2zbMugyrRSbL-vm1hYmDLJHmDSOWY';
  static const String googleSheetId =
      '1W0kRGhxx8xlm3wYuJ_5w5MWUdOG0Uvut7YJk6JA8AzQ';
  static const String getEmployeesFromGoogleSheet =
      'https://sheets.googleapis.com/v4/spreadsheets/$googleSheetId/values/A1:C?key=$googleApiKey&&majorDimension=COLUMNS';

  // Auth
  static const String me = '$baseUrl/api/auth/me';
  static const String login = '$baseUrl/api/auth/login';
  static const String loginWithGoogle = '$baseUrl/api/auth/login/google';
  static const String register = '$baseUrl/api/auth/register';
  static const String registerWithGoogle = '$baseUrl/api/auth/register/google';
  static const String forgotPassword = '$baseUrl/api/auth/forgot-password';
  static const String validateOTP = '$baseUrl/api/auth/validate-otp';
  static const String resetPassword = '$baseUrl/api/auth/reset-password';
  static const String logout = '$baseUrl/api/auth/logout';

  static const String getUsers = '$baseUrl/api/users';

  // Dashboard
  static const String sections = '$baseUrl/api/sections';
  static const String recentlyOpenedForms = '$baseUrl/api/workers/forms';

  // Sections
  static const String formsBySectionIdOrName =
      '$baseUrl/api/sections/:idOrName/forms';

  static const String openedFormsBySectionIdOrName =
      '$baseUrl/api/sections/:idOrName/opened-forms';

  // Forms
  static const String createForm = '$baseUrl/api/workers/forms/create';
  static const String getForm = '$baseUrl/api/workers/forms/:id';
  static const String recentlyOpenedFormsForSection =
      '$baseUrl/api/workers/section/:idOrName/forms';

  // Forms Answering
  static const String saveForm = '$baseUrl/api/workers/forms/:id/draft';
  static const String submitForm = '$baseUrl/api/workers/forms/:id/submit';

  // Creation
  static const String employees = '$baseUrl/api/create/employees';
  static const String addSection = '$baseUrl/api/create/section';
  static const String addForms = '$baseUrl/api/create/forms';
  static const String addSubForms = '$baseUrl/api/create/sub-forms';
  static const String addQuestions = '$baseUrl/api/create/questions';

  static const String deleteUsers = '$baseUrl/api/delete/users';
}
