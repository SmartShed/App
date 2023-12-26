// ignore_for_file: constant_identifier_names

mixin Section_LocaleData {
  static const String no_forms_found = 'section_no_forms_found';
  static const String forms_for_section = 'section_forms_for_section';
  static const String no_recently_opened_forms_found =
      'section_no_recently_opened_forms_found';
  static const String recently_opened_forms = 'section_recently_opened_forms';
  static const String no_opened_forms_found = 'section_no_opened_forms_found';
  static const String opened_forms = 'section_opened_forms';

  static const Map<String, dynamic> EN = {
    no_forms_found: 'No forms found',
    forms_for_section: 'Forms for %a',
    no_recently_opened_forms_found: 'No recently opened forms found',
    recently_opened_forms: 'Recently opened forms',
    no_opened_forms_found: 'No opened forms found',
    opened_forms: 'Opened forms',
  };

  static const Map<String, dynamic> HI = {
    no_forms_found: 'कोई फॉर्म नहीं मिला',
    forms_for_section: '%a के लिए फॉर्म',
    no_recently_opened_forms_found: 'कोई हाल ही में खोले गए फॉर्म नहीं मिला',
    recently_opened_forms: 'हाल ही में खोले गए फॉर्म',
    no_opened_forms_found: 'कोई खोले गए फॉर्म नहीं मिला',
    opened_forms: 'खोले गए फॉर्म',
  };
}
