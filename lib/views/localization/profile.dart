// ignore_for_file: constant_identifier_names

mixin Profile_LocaleData {
  static const String title = 'profile_title';
  static const String name = 'profile_name';
  static const String email = 'profile_email';
  static const String position = 'profile_position';
  static const String section = 'profile_section';
  static const String logout = 'profile_logout';

  static const Map<String, dynamic> EN = {
    title: 'PROFILE',
    name: 'Name',
    email: 'Email',
    position: 'Position',
    section: 'Section',
    logout: 'Logout',
  };

  static const Map<String, dynamic> HI = {
    title: 'प्रोफ़ाइल',
    name: 'नाम',
    email: 'ईमेल',
    position: 'पद',
    section: 'अनुभाग',
    logout: 'लॉग आउट',
  };
}
