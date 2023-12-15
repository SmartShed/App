import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'const.dart';

class ManageFormsPageMobile extends StatefulWidget {
  const ManageFormsPageMobile({super.key});

  @override
  State<ManageFormsPageMobile> createState() => _ManageFormsPageMobileState();
}

class _ManageFormsPageMobileState extends State<ManageFormsPageMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: const MyDrawer(),
      body: buildBody(),
    );
  }
}
