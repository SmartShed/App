import 'package:flutter/material.dart';

import '../../../pages.dart';
import '../../../responsive/responsive_layout.dart';
import 'desktop.dart';
import 'mobile.dart';

// ignore: camel_case_types
class Manage_CreateFormPage extends StatelessWidget {
  static const routeName = '${ManageFormsPage.routeName}/create-form';

  final String title;

  const Manage_CreateFormPage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: Manage_CreateFormPageMobile(title: title),
      desktopBody: Manage_CreateFormPageDesktop(title: title),
    );
  }
}
