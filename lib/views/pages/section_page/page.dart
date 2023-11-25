import 'package:flutter/material.dart';

import '../../responsive/responsive_layout.dart';
import '../../../models/section.dart';
import './mobile.dart';
import './desktop.dart';

class SectionPage extends StatelessWidget {
  static const String routeName = '/section';

  final String sectionId;
  final String sectionName;

  const SectionPage({
    Key? key,
    required this.sectionId,
    required this.sectionName,
  }) : super(key: key);

  factory SectionPage.fromSection(SmartShedSection section) {
    return SectionPage(
      sectionId: section.id,
      sectionName: section.name,
    );
  }

  factory SectionPage.fromSectionJson(Map<String, dynamic> json) {
    return SectionPage.fromSection(SmartShedSection.fromJson(json));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: SectionPageMobile(
        sectionId: sectionId,
        sectionName: sectionName,
      ),
      desktopBody: SectionPageDesktop(
        sectionId: sectionId,
        sectionName: sectionName,
      ),
    );
  }
}
