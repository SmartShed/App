import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'const.dart' as const_file;
import 'const.dart';

class SettingsPageMobile extends StatefulWidget {
  const SettingsPageMobile({super.key});

  @override
  State<SettingsPageMobile> createState() => _SettingsPageMobileState();
}

class _SettingsPageMobileState extends State<SettingsPageMobile> {
  @override
  void initState() {
    super.initState();
    initConst(setState, true);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          child: buildBody(),
        ),
      ),
    );
  }
}
