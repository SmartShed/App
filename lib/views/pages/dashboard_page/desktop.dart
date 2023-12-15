import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
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
    init();
  }

  @override
  Widget build(BuildContext context) {
    const_file.changeState = setState;
    const_file.context = context;

    return Scaffold(
      backgroundColor: ColorConstants.bg,
      appBar: buildAppBar(),
      body: RefreshIndicator(
        onRefresh: () async => init(),
        child: Row(
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
      ),
    );
  }
}
