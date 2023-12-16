import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'const.dart' as const_file;
import 'const.dart';

class SectionPageDesktop extends StatefulWidget {
  final String title;

  const SectionPageDesktop({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<SectionPageDesktop> createState() => _SectionPageDesktopState();
}

class _SectionPageDesktopState extends State<SectionPageDesktop> {
  @override
  void initState() {
    super.initState();
    initConst(widget.title, setState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
