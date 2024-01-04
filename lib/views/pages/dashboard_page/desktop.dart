import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'const.dart' as const_file;
import 'const.dart';

class DashboardPageDesktop extends StatefulWidget {
  const DashboardPageDesktop({super.key});

  @override
  State<DashboardPageDesktop> createState() => _DashboardPageDesktopState();
}

class _DashboardPageDesktopState extends State<DashboardPageDesktop> {
  @override
  void initState() {
    super.initState();
    const_file.changeState = setState;
    initConst();
  }

  @override
  void didChangeDependencies() {
    initConst();
    super.didChangeDependencies();
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
                child: buildMainBody(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
