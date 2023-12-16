import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'const.dart' as const_file;
import 'const.dart';

class SectionPageMobile extends StatefulWidget {
  final String title;

  const SectionPageMobile({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<SectionPageMobile> createState() => _SectionPageMobileState();
}

class _SectionPageMobileState extends State<SectionPageMobile> {
  @override
  void initState() {
    super.initState();
    initConst(widget.title, setState);
  }

  @override
  Widget build(BuildContext context) {
    const_file.context = context;

    return Scaffold(
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
