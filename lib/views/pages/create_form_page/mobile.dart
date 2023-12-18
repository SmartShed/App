import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'const.dart' as const_file;
import 'const.dart';

class CreateFormPageMobile extends StatefulWidget {
  final String formId;
  final String title;
  final String descriptionEnglish;
  final String descriptionHindi;

  const CreateFormPageMobile({
    Key? key,
    required this.formId,
    required this.title,
    required this.descriptionEnglish,
    required this.descriptionHindi,
  }) : super(key: key);

  @override
  State<CreateFormPageMobile> createState() => _CreateFormPageMobileState();
}

class _CreateFormPageMobileState extends State<CreateFormPageMobile> {
  @override
  void initState() {
    super.initState();
    initConst(
      widget.formId,
      widget.title,
      widget.descriptionEnglish,
      widget.descriptionHindi,
    );
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
            horizontal: 40,
            vertical: 40,
          ),
          child: buildMainBody(),
        ),
      ),
    );
  }
}
