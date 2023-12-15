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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: const MyDrawer(),
      body: buildBody(),
    );
  }
}
