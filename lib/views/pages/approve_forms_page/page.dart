import 'package:flutter/material.dart';
import 'package:smartshed/utils/api/forms_approve.dart';

import '../../responsive/responsive_layout.dart';
import 'desktop.dart';
import 'mobile.dart';

class ApproveFormsPage extends StatelessWidget {
  static const String routeName = '/approve-forms';

  const ApproveFormsPage({super.key});

  @override
  Widget build(BuildContext context) {
    FormsApproveApiHandler().getUnapprovedForms();

    return const ResponsiveLayout(
      mobileBody: ApproveFormsPageMobile(),
      desktopBody: ApproveFormsPageDesktop(),
    );
  }
}
