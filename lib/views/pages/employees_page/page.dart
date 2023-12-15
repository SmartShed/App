import 'package:flutter/material.dart';

import '../../responsive/responsive_layout.dart';
import 'desktop.dart';
import 'mobile.dart';

class EmployeesPage extends StatelessWidget {
  static const String routeName = '/employees';

  const EmployeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileBody: EmployeesPageMobile(),
      desktopBody: EmployeesPageDesktop(),
    );
  }
}
