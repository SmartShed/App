class APIConstants {
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
  static String validateToken = '$baseUrl/api/auth/validate-token';

  static String getUsers = '$baseUrl/api/users';

  // Dashboard
  static String sections = '$baseUrl/api/sections';
  static String recentlyOpenedForms = '$baseUrl/api/workers/forms';

  // Notifications
  static String getNotifications =
      '$baseUrl/api/notifications/getnotifications';
  static String markNotificationAsRead =
      '$baseUrl/api/notifications/marknotificationasread/:id';
  static String deleteNotification =
      '$baseUrl/api/notifications/deletenotification/:id';
  static String deleteAllNotifications =
      '$baseUrl/api/notifications/deleteallnotifications';

  // Sections
  static String formsBySectionIdOrName =
      '$baseUrl/api/sections/:idOrName/forms';

  static String openedFormsBySectionIdOrName =
      '$baseUrl/api/sections/:idOrName/opened-forms';

  // Forms
  static String createForm = '$baseUrl/api/workers/forms/create';
  static String getForm = '$baseUrl/api/workers/forms/:id';
  static String getUnopenedForm = '$baseUrl/api/workers/forms/opening/:id';
  static String recentlyOpenedFormsForSection =
      '$baseUrl/api/workers/section/:idOrName/forms';

  // Forms Answering
  static String saveForm = '$baseUrl/api/workers/forms/:id/draft';
  static String submitForm = '$baseUrl/api/workers/forms/:id/submit';

  // Creation
  static String employees = '$baseUrl/api/create/employees';
  static String addSection = '$baseUrl/api/create/section';
  static String addForm = '$baseUrl/api/create/form';
  static String addSubForm = '$baseUrl/api/create/sub-form';
  static String addQuestion = '$baseUrl/api/create/question';

  static String deleteUsers = '$baseUrl/api/delete/users';

  // Supervisors
  static String getUnapprovedFormsForSupervisor =
      '$baseUrl/api/supervisors/forms/unapproved';
  static String getApprovedFormsForSupervisor =
      '$baseUrl/api/supervisors/forms/approved';
  static String approveFormForSupervisor =
      '$baseUrl/api/supervisors/forms/approve';
  static String rejectFormForSupervisor =
      '$baseUrl/api/supervisors/forms/reject';

  // Authorities
  static String getUnapprovedFormsForAuthority =
      '$baseUrl/api/authorities/forms/unapproved';
  static String getApprovedFormsForAuthority =
      '$baseUrl/api/authorities/forms/approved';
  static String approveFormForAuthority =
      '$baseUrl/api/authorities/forms/approve';
  static String rejectFormForAuthority =
      '$baseUrl/api/authorities/forms/reject';

  static String getFaqs = '$baseUrl/api/faqs/:position';

  static late String userManualUrl;

  static void setUserManualUrl(String url) {
    userManualUrl = url;
  }
}
