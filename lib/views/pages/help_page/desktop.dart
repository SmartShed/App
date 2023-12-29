import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'const.dart' as const_file;
import 'const.dart';

class HelpPageDesktop extends StatefulWidget {
  const HelpPageDesktop({super.key});

  @override
  State<HelpPageDesktop> createState() => _HelpPageDesktopState();
}

class _HelpPageDesktopState extends State<HelpPageDesktop> {
  @override
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
      body: Row(
        children: [
          const MyDrawer(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 30,
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
