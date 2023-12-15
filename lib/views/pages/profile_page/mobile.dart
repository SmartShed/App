import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../widgets/drawer.dart';
import 'const.dart' as const_file;
import 'const.dart';

class ProfilePageMobile extends StatelessWidget {
  final SmartShedUser user;

  const ProfilePageMobile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const_file.user = user;

    return Scaffold(
      appBar: buildAppBar(),
      drawer: const MyDrawer(),
      body: SizedBox(
        width: double.infinity,
        child: buildProfile(),
      ),
    );
  }
}
