import 'package:flutter/material.dart';

import '../../responsive/responsive_layout.dart';
import 'mobile.dart';
import 'desktop.dart';

class DashboardPage extends StatelessWidget {
  static const String routeName = '/dashboard';

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileBody: DashboardPageMobile(),
      desktopBody: DashboardPageDesktop(),
    );
  }
}
