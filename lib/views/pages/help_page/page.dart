import 'package:flutter/material.dart';

import '../../responsive/responsive_layout.dart';
import 'desktop.dart';
import 'mobile.dart';

class HelpPage extends StatelessWidget {
  static const routeName = '/help';

  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobileBody: HelpPageMobile(),
      desktopBody: HelpPageDesktop(),
    );
  }
}
