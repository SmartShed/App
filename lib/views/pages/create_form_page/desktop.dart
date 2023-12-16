import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../widgets/drawer.dart';
import 'const.dart' as const_file;
import 'const.dart';

class CreateFormPageDesktop extends StatefulWidget {
  final String formId;
  final String title;
  final String descriptionEnglish;
  final String descriptionHindi;

  const CreateFormPageDesktop({
    Key? key,
    required this.formId,
    required this.title,
    required this.descriptionEnglish,
    required this.descriptionHindi,
  }) : super(key: key);

  @override
  State<CreateFormPageDesktop> createState() => _CreateFormPageDesktopState();
}

class _CreateFormPageDesktopState extends State<CreateFormPageDesktop> {
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
      backgroundColor: ColorConstants.bg,
      appBar: buildAppBar(),
      body: Row(
        children: [
          const MyDrawer(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.15,
                vertical: 40,
              ),
              child: buildMainBody(),
            ),
          ),
        ],
      ),
    );
  }
}
