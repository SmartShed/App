import 'package:flutter/material.dart';

import '../../../pages.dart';
import '../../../responsive/responsive_layout.dart';
import 'desktop.dart';
import 'mobile.dart';

// ignore: camel_case_types
class Manage_ManageFormPage extends StatelessWidget {
  static const routeName = '${ManageFormsPage.routeName}/manage-form';

  final String id;

  const Manage_ManageFormPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: Manage_ManageFormPageMobile(id: id),
      desktopBody: Manage_ManageFormPageDesktop(id: id),
    );
  }
}
