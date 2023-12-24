import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'const.dart' as const_file;
import 'const.dart';

class ManageFormsPageMobile extends StatefulWidget {
  const ManageFormsPageMobile({super.key});

  @override
  State<ManageFormsPageMobile> createState() => _ManageFormsPageMobileState();
}

class _ManageFormsPageMobileState extends State<ManageFormsPageMobile> {
  @override
  void initState() {
    super.initState();
    initConst(setState);
  }

  @override
  void dispose() {
    disposeConst();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const_file.context = context;

    return Scaffold(
      appBar: buildAppBar(),
      drawer: const MyDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          initSections();
          initForms();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: buildBody(),
          ),
        ),
      ),
    );
  }
}
