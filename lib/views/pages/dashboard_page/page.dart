import 'package:flutter/material.dart';

import '../../responsive/responsive_layout.dart';
import 'desktop.dart';
import 'mobile.dart';

class DashboardPage extends StatelessWidget {
  static const String routeName = '/';

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileBody: DashboardPageMobile(),
      desktopBody: DashboardPageDesktop(),
    );
  }
}
