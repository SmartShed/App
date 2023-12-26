// ignore_for_file: constant_identifier_names

mixin Manage_CreateForm_LocaleData {
  static const String title = 'manage_create_form_title';
  static const String create_form_for_section =
      'manage_create_form_create_form_for_section';
  static const String enter_form_details =
      'manage_create_form_enter_form_details';
  static const String form_title = 'manage_create_form_form_title';
  static const String english_description =
      'manage_create_form_english_description';
  static const String hindi_description =
      'manage_create_form_hindi_description';
  static const String create_form = 'manage_create_form_create_form';
  static const String creating_form = 'manage_create_form_creating_form';
  static const String form_created = 'manage_create_form_form_created';

  static const Map<String, dynamic> EN = {
    title: 'CREATE FORM',
    create_form_for_section: 'Create Form for %a',
    enter_form_details: 'Enter the details of the form you want to create.',
    form_title: 'Form Title',
    english_description: 'English Description (Optional)',
    hindi_description: 'Hindi Description (Optional)',
    create_form: 'Create Form',
    creating_form: 'Creating Form...',
    form_created: 'Form created successfully!',
  };

  static const Map<String, dynamic> HI = {
    title: 'फॉर्म बनाएं',
    create_form_for_section: '%a के लिए फॉर्म बनाएं',
    enter_form_details: 'वह विवरण दर्ज करें जिसे आप बनाना चाहते हैं।',
    form_title: 'फॉर्म का शीर्षक',
    english_description: 'अंग्रेजी विवरण (वैकल्पिक)',
    hindi_description: 'हिंदी विवरण (वैकल्पिक)',
    create_form: 'फॉर्म बनाएं',
    creating_form: 'फॉर्म बनाया जा रहा है...',
    form_created: 'फॉर्म सफलतापूर्वक बनाया गया!',
  };
}
