import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'const.dart';

class NotificationsPageDesktop extends StatefulWidget {
  const NotificationsPageDesktop({super.key});

  @override
  State<NotificationsPageDesktop> createState() =>
      _NotificationsPageDesktopState();
}

class _NotificationsPageDesktopState extends State<NotificationsPageDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Row(
        children: [
          const MyDrawer(),
          Expanded(
            child: buildBody(),
          ),
        ],
      ),
    );
  }
}
