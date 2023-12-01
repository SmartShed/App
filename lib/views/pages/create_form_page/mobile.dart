import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../widgets/drawer.dart';
import '../../widgets/text_field.dart';
import './const.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bg,
      appBar: buildAppBar("Create ${widget.title} Form", () {}),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 40,
        ),
        child: buildMainBody(
          context,
          widget.formId,
          widget.title,
          widget.descriptionEnglish,
          widget.descriptionHindi,
        ),
      ),
    );
  }
}
