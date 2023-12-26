// ignore_for_file: constant_identifier_names

mixin Logout_LocaleData {
  static const String logout_message = 'logout_logout_message';
  static const String no = 'logout_no';
  static const String yes = 'logout_yes';
  static const String logging_out = 'logout_logging_out';
  static const String logged_out = 'logout_logged_out';

  static const Map<String, dynamic> EN = {
    logout_message: 'Are you sure you want to logout?',
    no: 'No',
    yes: 'Yes',
    logging_out: 'Logging out...',
    logged_out: 'Logged out successfully.',
  };

  static const Map<String, dynamic> HI = {
    logout_message: 'क्या आप वाकई लॉगआउट करना चाहते हैं?',
    no: 'नहीं',
    yes: 'हाँ',
    logging_out: 'लॉगआउट हो रहा है...',
    logged_out: 'सफलतापूर्वक लॉगआउट हो गया।',
  };
}
