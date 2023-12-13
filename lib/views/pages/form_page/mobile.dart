import 'package:flutter/material.dart';

import '../../../controllers/forms/opening.dart';
import '../../../models/opened_form.dart';
import '../../widgets/drawer.dart';
import 'const.dart' as const_file;
import 'const.dart';

class FormPageMobile extends StatefulWidget {
  final String id;
  final SmartShedOpenedForm? data;

  const FormPageMobile({
    Key? key,
    required this.id,
    this.data,
  }) : super(key: key);

  @override
  State<FormPageMobile> createState() => _FormPageMobileState();
}

class _FormPageMobileState extends State<FormPageMobile> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initForm();
  }

  void _initForm() async {
    form = await FormOpeningController.getForm(widget.id);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    const_file.data = widget.data;
    const_file.context = context;
    const_file.changeState = setState;

    if (isLoading) return buildLoading();

    return Scaffold(
      appBar: buildAppBar(),
      drawer: const MyDrawer(),
      body: Scrollbar(
        thickness: 5,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 10,
            ),
            child: buildMainBody(),
          ),
        ),
      ),
    );
  }
}
