import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'const.dart' as const_file;
import 'const.dart';

class DashboardPageMobile extends StatefulWidget {
  const DashboardPageMobile({super.key});

  @override
  State<DashboardPageMobile> createState() => _DashboardPageMobileState();
}

class _DashboardPageMobileState extends State<DashboardPageMobile> {
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
      drawer: const MyDrawer(),
      body: RefreshIndicator(
        onRefresh: () async => initConst(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30,
            ),
            child: buildMainBody(),
          ),
        ),
      ),
    );
  }
}
