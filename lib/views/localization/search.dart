// ignore_for_file: constant_identifier_names

mixin Search_LocaleData {
  static const String title = 'search_title';
  static const String form_title = 'search_form_title';
  static const String loco_type = 'search_loco_type';
  static const String loco_number = 'search_loco_number';
  static const String search = 'search_search';
  static const String search_for_forms = 'search_search_for_forms';
  static const String no_forms_found = 'search_no_form_found';

  static const Map<String, dynamic> EN = {
    title: 'SEARCH',
    form_title: 'Form Title',
    loco_type: 'Loco Type',
    loco_number: 'Loco Number',
    search: 'Search',
    search_for_forms: 'Search for forms',
    no_forms_found: 'No forms found',
  };

  static const Map<String, dynamic> HI = {
    title: 'खोज',
    form_title: 'फॉर्म शीर्षक',
    loco_type: 'लोको प्रकार',
    loco_number: 'लोको नंबर',
    search: 'खोज',
    search_for_forms: 'फॉर्मों के लिए खोजें',
    no_forms_found: 'कोई फॉर्म नहीं मिला',
  };
}
