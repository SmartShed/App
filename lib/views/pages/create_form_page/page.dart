import 'package:flutter/material.dart';

import '../../responsive/responsive_layout.dart';
import '../../../models/unopened_form.dart';
import 'mobile.dart';
import 'desktop.dart';

class CreateFormPage extends StatelessWidget {
  static const String routeName = '/create-form';

  final String formId;
  final String title;
  final String descriptionEnglish;
  final String descriptionHindi;

  const CreateFormPage({
    Key? key,
    required this.formId,
    required this.title,
    required this.descriptionEnglish,
    required this.descriptionHindi,
  }) : super(key: key);

  factory CreateFormPage.fromForm(SmartShedUnopenedForm form) {
    return CreateFormPage(
      formId: form.id,
      title: form.title,
      descriptionEnglish: form.descriptionEnglish,
      descriptionHindi: form.descriptionHindi,
    );
  }

  factory CreateFormPage.fromFormJson(Map<String, dynamic> json) {
    return CreateFormPage.fromForm(SmartShedUnopenedForm.fromJson(json));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: CreateFormPageMobile(
        formId: formId,
        title: title,
        descriptionEnglish: descriptionEnglish,
        descriptionHindi: descriptionHindi,
      ),
      desktopBody: CreateFormPageDesktop(
        formId: formId,
        title: title,
        descriptionEnglish: descriptionEnglish,
        descriptionHindi: descriptionHindi,
      ),
    );
  }
}
