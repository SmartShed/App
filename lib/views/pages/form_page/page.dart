import 'package:flutter/material.dart';

import '../../../models/opened_form.dart';
import '../../responsive/responsive_layout.dart';
import 'desktop.dart';
import 'mobile.dart';

class FormPage extends StatelessWidget {
  static const String routeName = '/form';

  final String id;
  final SmartShedOpenedForm? data;

  const FormPage({
    Key? key,
    required this.id,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: FormPageMobile(id: id, data: data),
      desktopBody: FormPageDesktop(id: id, data: data),
    );
  }
}
