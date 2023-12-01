import 'package:flutter/material.dart';

import '../../responsive/responsive_layout.dart';
import '../../../models/section.dart';
import './mobile.dart';
import './desktop.dart';

class SectionPage extends StatelessWidget {
  static const String routeName = '/section';

  final String title;

  const SectionPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  factory SectionPage.fromSection(SmartShedSection section) {
    return SectionPage(
      title: section.title,
    );
  }

  factory SectionPage.fromSectionJson(Map<String, dynamic> json) {
    return SectionPage.fromSection(SmartShedSection.fromJson(json));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: SectionPageMobile(title: title),
      desktopBody: SectionPageDesktop(title: title),
    );
  }
}
