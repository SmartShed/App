import 'package:flutter/material.dart';

import '../../../widgets/drawer.dart';
import 'const.dart';

// ignore: camel_case_types
class Manage_CreateFormPageMobile extends StatelessWidget {
  final String title;

  const Manage_CreateFormPageMobile({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    initConst(context, title);

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
