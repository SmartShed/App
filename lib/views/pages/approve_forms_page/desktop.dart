import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'const.dart' as const_file;
import 'const.dart';

class ApproveFormsPageDesktop extends StatefulWidget {
  const ApproveFormsPageDesktop({super.key});

  @override
  State<ApproveFormsPageDesktop> createState() =>
      _ApproveFormsPageDesktopState();
}

class _ApproveFormsPageDesktopState extends State<ApproveFormsPageDesktop> {
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 30,
                ),
                child: buildBody(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
