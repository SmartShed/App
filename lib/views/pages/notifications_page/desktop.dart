import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'const.dart' as const_file;
import 'const.dart';

class NotificationsPageDesktop extends StatefulWidget {
  const NotificationsPageDesktop({super.key});

  @override
  State<NotificationsPageDesktop> createState() =>
      _NotificationsPageDesktopState();
}

class _NotificationsPageDesktopState extends State<NotificationsPageDesktop> {
  @override
  void initState() {
    super.initState();
    initConst(setState);
  }

  @override
  Widget build(BuildContext context) {
    const_file.context = context;

    return Scaffold(
      appBar: buildAppBar(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MyDrawer(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              child: buildBody(),
            ),
          ),
        ],
      ),
    );
  }
}
