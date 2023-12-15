import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'const.dart';

class ManageFormsPageDesktop extends StatefulWidget {
  const ManageFormsPageDesktop({super.key});

  @override
  State<ManageFormsPageDesktop> createState() => _ManageFormsPageDesktopState();
}

class _ManageFormsPageDesktopState extends State<ManageFormsPageDesktop> {
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
