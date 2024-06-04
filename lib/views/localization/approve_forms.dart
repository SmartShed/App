// ignore_for_file: constant_identifier_names

mixin ApproveForms_LocaleData {
  static const String title = 'approve_forms_title';
  static const String no_form_found = 'approve_forms_no_form_found';
  static const String forms_to_approve = 'approve_forms_forms_to_approve';
  static const String approved_forms = 'approve_forms_approved_forms';
  static const String approved_forms_empty =
      'approve_forms_approved_forms_empty';

  static const Map<String, dynamic> EN = {
    title: 'APPROVE FORMS',
    no_form_found: 'No forms found to approve',
    forms_to_approve: 'Forms to Approve',
    approved_forms: 'Approved Forms',
    approved_forms_empty: 'No approved forms found',
  };

  static const Map<String, dynamic> HI = {
    title: 'फॉर्मों स्वीकृति',
    no_form_found: 'स्वीकृति के लिए कोई फॉर्म नहीं मिला',
    forms_to_approve: 'स्वीकृति के लिए फॉर्म',
    approved_forms: 'स्वीकृत फॉर्म',
    approved_forms_empty: 'कोई स्वीकृत फॉर्म नहीं मिला',
  };
}
