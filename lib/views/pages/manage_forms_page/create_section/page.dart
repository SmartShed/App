import 'package:flutter/material.dart';

import '../../../pages.dart';
import '../../../responsive/responsive_layout.dart';
import 'desktop.dart';
import 'mobile.dart';

// ignore: camel_case_types
class Manage_CreateSectionPage extends StatelessWidget {
  static const routeName = '${ManageFormsPage.routeName}/create-section';

  const Manage_CreateSectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileBody: Manage_CreateSectionPageMobile(),
      desktopBody: Manage_CreateSectionPageDesktop(),
    );
  }
}
