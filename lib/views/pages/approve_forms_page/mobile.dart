import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'const.dart' as const_file;
import 'const.dart';

class ApproveFormsPageMobile extends StatefulWidget {
  const ApproveFormsPageMobile({super.key});

  @override
  State<ApproveFormsPageMobile> createState() => _ApproveFormsPageMobileState();
}

class _ApproveFormsPageMobileState extends State<ApproveFormsPageMobile> {
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
      drawer: const MyDrawer(),
      body: RefreshIndicator(
        onRefresh: () async => initConst(setState),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30,
            ),
            child: buildBody(),
          ),
        ),
      ),
    );
  }
}
