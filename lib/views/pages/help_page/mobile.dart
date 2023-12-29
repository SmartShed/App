import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'const.dart' as const_file;
import 'const.dart';

class HelpPageMobile extends StatefulWidget {
  const HelpPageMobile({super.key});

  @override
  State<HelpPageMobile> createState() => _HelpPageMobileState();
}

class _HelpPageMobileState extends State<HelpPageMobile> {
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
