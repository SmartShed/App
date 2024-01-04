import 'package:flutter/material.dart';

import '../../../widgets/drawer.dart';
import 'const.dart' as const_file;
import 'const.dart';

// ignore: camel_case_types
class Manage_ManageFormPageDesktop extends StatefulWidget {
  final String id;

  const Manage_ManageFormPageDesktop({Key? key, required this.id})
      : super(key: key);

  @override
  State<Manage_ManageFormPageDesktop> createState() =>
      _Manage_ManageFormPageDesktopState();
}

// ignore: camel_case_types
class _Manage_ManageFormPageDesktopState
    extends State<Manage_ManageFormPageDesktop> {
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
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MyDrawer(),
          Expanded(
            child: Scrollbar(
              thickness: 5,
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
          ),
        ],
      ),
    );
  }
}
