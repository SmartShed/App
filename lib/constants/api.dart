class APIConstants {
  // AWS EC2
  // static const String baseUrl = 'http://13.233.17.93';

  // Render
  // static const String baseUrl = 'https://smartshed-backend.onrender.com';

  // Localhost
  // static const String baseUrl = 'http://localhost:8000';

  static late String baseUrl;

  static const String defaultBaseUrl = 'https://smartshed-backend.onrender.com';

  static void setBaseUrl(String url) {
    baseUrl = url;
  }

  static void setDefaultBaseUrl() {
    baseUrl = defaultBaseUrl;
  }

  // Constants for Google Sign In API
  static const String googleClientId =
      "733510285262-g2o3upi13pbohg452f9esash3tlmf88s.apps.googleusercontent.com";

  static const String googleApiKey = 'AIzaSyAPOJ2zbMugyrRSbL-vm1hYmDLJHmDSOWY';

  static const String emplyeesGoogleSheetId =
      '1W0kRGhxx8xlm3wYuJ_5w5MWUdOG0Uvut7YJk6JA8AzQ';

  static const String backendUrlGoogleSheetId =
      '1wFfpB4ycK0ALAlHQ3-sCBbGiHQuDuBv6F_82RDZUwes';

  static const String getEmployeesFromGoogleSheet =
      'https://sheets.googleapis.com/v4/spreadsheets/$emplyeesGoogleSheetId/values/A1:C?key=$googleApiKey&&majorDimension=COLUMNS';

  static const String getBackendUrlFromGoogleSheet =
      'https://sheets.googleapis.com/v4/spreadsheets/$backendUrlGoogleSheetId/values/A1:B?key=$googleApiKey';

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
