import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'const.dart';

class ApproveFormsPageMobile extends StatefulWidget {
  const ApproveFormsPageMobile({super.key});

  @override
  State<ApproveFormsPageMobile> createState() => _ApproveFormsPageMobileState();
}

class _ApproveFormsPageMobileState extends State<ApproveFormsPageMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: const MyDrawer(),
      body: buildBody(),
    );
  }
}
