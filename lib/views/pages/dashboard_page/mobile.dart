import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
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
    init();
  }

  @override
  Widget build(BuildContext context) {
    const_file.changeState = setState;
    const_file.context = context;

    return Scaffold(
      backgroundColor: ColorConstants.bg,
      appBar: buildAppBar(),
      drawer: const MyDrawer(),
      body: RefreshIndicator(
        onRefresh: () async => init(),
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
