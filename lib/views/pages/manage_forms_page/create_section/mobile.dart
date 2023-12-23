import 'package:flutter/material.dart';

import '../../../widgets/drawer.dart';
import 'const.dart';

// ignore: camel_case_types
class Manage_CreateSectionPageMobile extends StatelessWidget {
  const Manage_CreateSectionPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    initConst(context);

    return Scaffold(
      appBar: buildAppBar(),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 60,
            vertical: 40,
          ),
          child: buildBody(),
        ),
      ),
    );
  }
}
