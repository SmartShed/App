import 'package:flutter/material.dart';

import '../../responsive/responsive_layout.dart';
import 'desktop.dart';
import 'mobile.dart';

class ManageFormsPage extends StatelessWidget {
  static const String routeName = '/manage-forms';

  const ManageFormsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileBody: ManageFormsPageMobile(),
      desktopBody: ManageFormsPageDesktop(),
    );
  }
}
