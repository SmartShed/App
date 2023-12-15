import 'package:flutter/material.dart';

import '../../responsive/responsive_layout.dart';
import 'desktop.dart';
import 'mobile.dart';

class NotificationsPage extends StatelessWidget {
  static const String routeName = '/notifications';
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileBody: NotificationsPageMobile(),
      desktopBody: NotificationsPageDesktop(),
    );
  }
}
