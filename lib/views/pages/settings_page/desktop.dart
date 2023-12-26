import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'const.dart';

class SettingsPageDesktop extends StatefulWidget {
  const SettingsPageDesktop({super.key});

  @override
  State<SettingsPageDesktop> createState() => _SettingsPageDesktopState();
}

class _SettingsPageDesktopState extends State<SettingsPageDesktop> {
  @override
  void initState() {
    super.initState();
    initConst(setState, false);
  }

  @override
  void dispose() {
    disposeConst();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
