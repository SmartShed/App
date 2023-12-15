import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../responsive/responsive_layout.dart';
import 'desktop.dart';
import 'mobile.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';
  final SmartShedUser user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: ProfilePageMobile(user: user),
      desktopBody: ProfilePageDesktop(user: user),
    );
  }
}
