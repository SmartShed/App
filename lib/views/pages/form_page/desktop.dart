import 'package:flutter/material.dart';

import '../../../models/opened_form.dart';
import '../../widgets/drawer.dart';
import 'const.dart' as const_file;
import 'const.dart';

class FormPageDesktop extends StatefulWidget {
  final String id;
  final SmartShedOpenedForm? data;

  const FormPageDesktop({
    Key? key,
    required this.id,
    this.data,
  }) : super(key: key);

  @override
  State<FormPageDesktop> createState() => _FormPageDesktopState();
}

class _FormPageDesktopState extends State<FormPageDesktop> {
  @override
  void initState() {
    super.initState();
    initConst(widget.id, widget.data, setState, true);
  }

  @override
  Widget build(BuildContext context) {
    const_file.context = context;

    if (isLoading) return buildLoading();

    return Scaffold(
      appBar: buildAppBar(),
      body: Row(
        children: [
          const MyDrawer(),
          Expanded(
            child: Scrollbar(
              thickness: 5,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: buildMainBody(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
