import 'package:flutter/widgets.dart';

import '../../responsive/responsive_layout.dart';
import 'desktop.dart';
import 'mobile.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileBody: SettingsPageMobile(),
      desktopBody: SettingsPageDesktop(),
    );
  }
}
