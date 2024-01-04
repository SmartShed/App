import 'package:flutter/material.dart';

import '../../../widgets/drawer.dart';
import 'const.dart';

// ignore: camel_case_types
class Manage_CreateSectionPageDesktop extends StatelessWidget {
  const Manage_CreateSectionPageDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    initConst(context);

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
                  horizontal: 80,
                  vertical: 20,
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
