import 'package:flutter/material.dart';

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
  @override
  void initState() {
    super.initState();

    const_file.id = widget.id;
    const_file.data = widget.data;
    const_file.changeState = setState;

    initForm();
  }

  @override
  Widget build(BuildContext context) {
    const_file.context = context;

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
