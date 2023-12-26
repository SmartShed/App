// ignore_for_file: constant_identifier_names

mixin Dashboard_LocaleData {
  static const String title = 'dashboard_title';
  static const String sections = 'dashboard_sections';
  static const String no_section_found = 'dashboard_no_section_found';
  static const String recently_opened_forms = 'dashboard_recently_opened_forms';
  static const String no_recently_opened_form_found =
      'dashboard_no_recently_opened_form_found';

  static const Map<String, dynamic> EN = {
    title: 'DASHBOARD',
    sections: 'Sections',
    no_section_found: 'No section found',
    recently_opened_forms: 'Recently opened forms',
    no_recently_opened_form_found: 'No recently opened form found',
  };

  static const Map<String, dynamic> HI = {
    title: 'डैशबोर्ड',
    sections: 'सेक्शन',
    no_section_found: 'कोई सेक्शन नहीं मिला',
    recently_opened_forms: 'हाल ही में खोले गए फॉर्म',
    no_recently_opened_form_found: 'कोई हाल ही में खोला गया फॉर्म नहीं मिला',
  };
}
