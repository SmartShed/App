import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../widgets/drawer.dart';
import 'const.dart' as const_file;
import 'const.dart';

class ProfilePageDesktop extends StatelessWidget {
  static const routeName = '/profile';
  final SmartShedUser user;

  const ProfilePageDesktop({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const_file.context = context;
    const_file.user = user;

    return Scaffold(
      appBar: buildAppBar(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MyDrawer(),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: buildProfile(),
            ),
          ),
        ],
      ),
    );
  }
}
