import 'package:flutter/material.dart';

import '../../../widgets/drawer.dart';
import 'const.dart' as const_file;
import 'const.dart';

// ignore: camel_case_types
class Manage_ManageFormPageMobile extends StatefulWidget {
  final String id;

  const Manage_ManageFormPageMobile({Key? key, required this.id})
      : super(key: key);

  @override
  State<Manage_ManageFormPageMobile> createState() =>
      _Manage_ManageFormPageMobileState();
}

// ignore: camel_case_types
class _Manage_ManageFormPageMobileState
    extends State<Manage_ManageFormPageMobile> {
  @override
  void initState() {
    super.initState();
    initConst(widget.id, setState);
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
      body: Scrollbar(
        thickness: 5,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 10,
            ),
            child: buildBody(),
          ),
        ),
      ),
    );
  }
}
