import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'const.dart';

class NotificationsPageMobile extends StatefulWidget {
  const NotificationsPageMobile({super.key});

  @override
  State<NotificationsPageMobile> createState() =>
      _NotificationsPageMobileState();
}

class _NotificationsPageMobileState extends State<NotificationsPageMobile> {
  @override
  void initState() {
    super.initState();
    initConst(setState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: const MyDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          await notificationsController.fetchNotifications();
          changeState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          child: buildBody(),
        ),
      ),
    );
  }
}
