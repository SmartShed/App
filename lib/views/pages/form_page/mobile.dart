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

class _FormPageMobileState extends State<FormPageMobile>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    initConst(widget.id, widget.data, setState, false, this);
  }

  @override
  void dispose() {
    disposeConst();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const_file.context = context;

    if (isLoading) return buildLoading();

    return Scaffold(
      appBar: buildAppBar(),
      drawer: const MyDrawer(),
      floatingActionButton: buildFloatingActionButton(),
      body: Scrollbar(
        thickness: 5,
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
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
