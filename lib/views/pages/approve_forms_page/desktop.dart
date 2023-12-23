import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'const.dart';

class ApproveFormsPageDesktop extends StatefulWidget {
  const ApproveFormsPageDesktop({super.key});

  @override
  State<ApproveFormsPageDesktop> createState() =>
      _ApproveFormsPageDesktopState();
}

class _ApproveFormsPageDesktopState extends State<ApproveFormsPageDesktop> {
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
